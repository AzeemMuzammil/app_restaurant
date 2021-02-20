import 'package:app_restaurant/db/menu.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CustomerHomeEvent {}

class ErrorEvent extends CustomerHomeEvent {
  final String error;

  ErrorEvent(this.error);
}

class FetchMenusEvent extends CustomerHomeEvent {}

class ChangeMenusEvent extends CustomerHomeEvent {
  final List<Menu> menus;

  ChangeMenusEvent(this.menus);
}
