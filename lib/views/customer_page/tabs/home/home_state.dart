import 'package:app_restaurant/db/menu.dart';
import 'package:flutter/material.dart';

@immutable
class CustomerHomeState {
  final bool loading;
  final List<Menu> menues;
  final String error;

  CustomerHomeState({
    @required this.loading,
    @required this.menues,
    @required this.error,
  });

  CustomerHomeState clone({
    bool loading,
    List<Menu> menues,
    String error,
  }) {
    return CustomerHomeState(
      loading: loading ?? this.loading,
      menues: menues ?? this.menues,
      error: error ?? this.error,
    );
  }
}
