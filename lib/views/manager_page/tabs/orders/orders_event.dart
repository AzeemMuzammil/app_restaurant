import 'package:app_restaurant/db/order.dart';
import 'package:flutter/material.dart';

@immutable
abstract class OrdersEvent {}

class ErrorEvent extends OrdersEvent {
  final String error;

  ErrorEvent(this.error);
}

class FetchOrdersEvent extends OrdersEvent {}

class ChangeOrdersEvent extends OrdersEvent {
  final List<Order> orders;

  ChangeOrdersEvent(this.orders);
}

class UpdateOrderStatusEvent extends OrdersEvent {
  final Order order;

  UpdateOrderStatusEvent(this.order);
}
