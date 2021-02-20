import 'dart:async';

import 'package:app_restaurant/db/app_user.dart';
import 'package:app_restaurant/db/repos/authentication_repo.dart';
import 'package:app_restaurant/db/repos/user_repo.dart';
import 'package:app_restaurant/views/root_page/root_page.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final _authenticationRepo = AuthenticationRepo();
  final _userRepo = UserRepository();

  StreamSubscription _userSubscription;

  RootBloc()
      : super(
          RootState(
            error: "",
            page: RootState.LOADING_PAGE,
            user: null,
            loading: false,
          ),
        ) {
    add(HandleUserEvent());
  }

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error, loading: false);
        break;

      case HandleUserEvent:
        yield state.clone(loading: true);
        final loggedUser = await _authenticationRepo.getLoggedUser();
        if (loggedUser == null) {
          yield state.clone(page: RootState.AUTH_PAGE);
        } else {
          AppUser appUser = await _fetchUserLogged(loggedUser.uid);
          add(HandleLoggedInUserEvent(appUser));
        }
        break;

      case HandleLoggedInUserEvent:
        final appUser = (event as HandleLoggedInUserEvent).loggedInUser;
        if (appUser == null) {
          yield state.clone(page: RootState.AUTH_PAGE);
        } else {
          yield state.clone(page: RootState.HOME_PAGE);
          add(FetchLoggedInUserEvent(appUser));
        }
        break;

      case FetchLoggedInUserEvent:
        final user = (event as FetchLoggedInUserEvent).user;
        _userSubscription?.cancel();
        final addon = RepositoryAddon(repository: _userRepo);
        _userSubscription = addon.transform(ref: user.ref).listen(
          (user) {
            add(ChangeLoggedInUserEvent(user));
          },
        );
        break;

      case ChangeLoggedInUserEvent:
        final updatedUser = (event as ChangeLoggedInUserEvent).user;
        yield state.clone(user: updatedUser);
        break;

      case LogoutEvent:
        yield state.clone(loading: true);
        await _authenticationRepo.logout();
        yield state.clone(
          error: "",
          loading: false,
          page: RootState.AUTH_PAGE,
        );
        break;
    }
  }

  Future<AppUser> _fetchUserLogged(String uid) async {
    final appUsers = await _userRepo.querySingle(
        specification: ComplexSpecification(
      [
        ComplexWhere(
          AppUser.USER_ID,
          isEqualTo: uid,
        )
      ],
    ));
    if (appUsers.isEmpty) return null;
    return appUsers[0];
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    _userSubscription.cancel();
    await super.close();
  }

  void _addErr(e) {
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
