import 'package:flutter/material.dart';

@immutable
class AddProductState {
  final bool loading;
  final bool inserted;
  final String error;

  AddProductState({
    @required this.loading,
    @required this.inserted,
    @required this.error,
  });

  AddProductState clone({
    bool loading,
    bool inserted,
    String error,
  }) {
    return AddProductState(
      loading: loading ?? this.loading,
      inserted: inserted ?? this.inserted,
      error: error ?? this.error,
    );
  }
}
