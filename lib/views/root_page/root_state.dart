import 'package:app_restaurant/db/app_user.dart';
import 'package:flutter/material.dart';

@immutable
class RootState {
  static const LOADING_PAGE = 1;
  static const AUTH_PAGE = 2;
  static const HOME_PAGE = 3;

  final String error;
  final int page;
  final AppUser user;
  final bool loading;

  RootState({
    @required this.error,
    @required this.page,
    @required this.user,
    @required this.loading,
  });

  RootState clone({
    String error,
    int page,
    AppUser user,
    bool loading,
  }) {
    return RootState(
      error: error ?? this.error,
      page: page ?? this.page,
      user: user ?? this.user,
      loading: loading ?? this.loading,
    );
  }
}
