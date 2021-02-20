import 'package:app_restaurant/db/menu.dart';
import 'package:flutter/material.dart';

@immutable
class HomeState {
  final bool loading;
  final List<Menu> menues;
  final String error;

  HomeState({
    @required this.loading,
    @required this.menues,
    @required this.error,
  });

  HomeState clone({
    bool loading,
    List<Menu> menues,
    String error,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      menues: menues ?? this.menues,
      error: error ?? this.error,
    );
  }
}
