import 'package:app_restaurant/db/order.dart';
import 'package:flutter/material.dart';

@immutable
class OrdersState {
  final bool loading;
  final List<Order> orders;
  final String error;

  OrdersState({
    @required this.loading,
    @required this.orders,
    @required this.error,
  });

  OrdersState clone({
    bool loading,
    List<Order> orders,
    String error,
  }) {
    return OrdersState(
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }
}
