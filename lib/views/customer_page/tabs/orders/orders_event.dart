import 'package:app_restaurant/db/order.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CustomerOrdersEvent {}

class ErrorEvent extends CustomerOrdersEvent {
  final String error;

  ErrorEvent(this.error);
}

class FetchOrdersEvent extends CustomerOrdersEvent {}

class ChangeOrdersEvent extends CustomerOrdersEvent {
  final List<Order> orders;

  ChangeOrdersEvent(this.orders);
}
