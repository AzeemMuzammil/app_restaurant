import 'package:flutter/material.dart';

@immutable
class AuthState {
  final String error;
  final bool loggedIn;
  final bool loading;

  AuthState({
    @required this.error,
    @required this.loggedIn,
    @required this.loading,
  });

  AuthState clone({
    String error,
    bool loggedIn,
    bool loading,
  }) {
    return AuthState(
      error: error ?? this.error,
      loggedIn: loggedIn ?? this.loggedIn,
      loading: loading ?? this.loading,
    );
  }
}
