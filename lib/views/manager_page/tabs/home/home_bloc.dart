import 'dart:async';
import 'package:app_restaurant/db/repos/menu_repo.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/home_event.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final productRepo = MenuRepository();

  StreamSubscription _productsSubscription;

  HomeBloc(BuildContext context)
      : super(HomeState(
          loading: false,
          menues: null,
          error: "",
        )) {
    add(FetchMenusEvent());
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case FetchMenusEvent:
        yield state.clone(loading: true);
        try {
          _productsSubscription = productRepo
              .query(specification: ComplexSpecification([]))
              .listen((products) {
            add(ChangeMenusEvent(products));
          });
        } catch (e) {
          _addErr(e);
        }
        yield state.clone(loading: false);
        break;

      case ChangeMenusEvent:
        final products = (event as ChangeMenusEvent).menus;
        yield state.clone(loading: false, menues: products);
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    _productsSubscription.cancel();
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
