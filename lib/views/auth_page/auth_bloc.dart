import 'dart:async';

import 'package:app_restaurant/db/app_user.dart';
import 'package:app_restaurant/db/customer.dart';
import 'package:app_restaurant/db/manager.dart';
import 'package:app_restaurant/db/repos/authentication_repo.dart';
import 'package:app_restaurant/db/repos/user_repo.dart';
import 'package:app_restaurant/views/auth_page/auth_page.dart';
import 'package:app_restaurant/views/root_page/root_page.dart' hide ErrorEvent;
import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = AuthenticationRepo();
  final userRepo = UserRepository();
  final RootBloc rootBloc;

  AuthBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(
          AuthState(
            error: "",
            loading: false,
            loggedIn: false,
          ),
        );

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "", loading: false);
        yield state.clone(error: error);
        break;

      case LoginPressedEvent:
        final e = (event as LoginPressedEvent);
        final isManager = e.isManager;
        final email = e.email;
        final password = e.password;

        yield state.clone(loading: true);

        User loggedInUser;

        try {
          loggedInUser = await auth.login(email, password);
        } catch (e) {
          yield state.clone(
            loading: false,
            loggedIn: false,
            error: "Login Failed",
          );
          break;
        }

        if (loggedInUser?.email != null) {
          AppUser appUser = await _fetchUserLogged(loggedInUser.uid);
          if (isManager && appUser is Manager) {
            rootBloc.add(HandleUserEvent());
            yield state.clone(
              loading: false,
              loggedIn: true,
            );
          } else if (!isManager && appUser is Customer) {
            rootBloc.add(HandleUserEvent());
            yield state.clone(
              loading: false,
              loggedIn: true,
            );
          } else {
            rootBloc.add(LogoutEvent());
            yield state.clone(
              loading: false,
              loggedIn: false,
              error: "Login Failed",
            );
          }
        } else {
          yield state.clone(
            loading: false,
            loggedIn: false,
            error: "Login Failed",
          );
        }
        break;

      case RegisterPressedEvent:
        final e = (event as RegisterPressedEvent);
        final email = e.email;
        final firstName = e.firstName;
        final lastName = e.lastName;
        final password = e.password;

        yield state.clone(loading: true);

        User registeredUser;

        try {
          registeredUser = await auth.register(email, password);
        } catch (e) {
          yield state.clone(
            loading: false,
            loggedIn: false,
            error: "Registration Failed",
          );
          break;
        }

        if (registeredUser?.email != null) {
          final loggedUser = await auth.getLoggedUser();
          final uid = loggedUser.uid;
          final emailAddress = loggedUser.email;
          final user = Customer(
            (b) => b
              ..userId = uid
              ..emailAddress = emailAddress
              ..firstName = firstName
              ..lastName = lastName
              ..customerId = emailAddress,
          );
          await userRepo.add(
            item: user,
          );
          yield state.clone(
            loading: false,
            loggedIn: true,
          );
          rootBloc.add(HandleUserEvent());
        } else {
          yield state.clone(
            loading: false,
            loggedIn: false,
            error: "Registration Failed",
          );
        }
        break;
    }
  }

  Future<AppUser> _fetchUserLogged(String uid) async {
    final appUsers = await userRepo.querySingle(
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
