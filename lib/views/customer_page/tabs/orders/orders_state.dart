import 'package:app_restaurant/db/order.dart';
import 'package:flutter/material.dart';

@immutable
class CustomerOrdersState {
  final bool loading;
  final List<Order> orders;
  final String error;

  CustomerOrdersState({
    @required this.loading,
    @required this.orders,
    @required this.error,
  });

  CustomerOrdersState clone({
    bool loading,
    List<Order> orders,
    String error,
  }) {
    return CustomerOrdersState(
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}
