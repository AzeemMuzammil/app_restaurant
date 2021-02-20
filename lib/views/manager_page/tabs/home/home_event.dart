import 'package:app_restaurant/db/menu.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class ErrorEvent extends HomeEvent {
  final String error;

  ErrorEvent(this.error);
}

class FetchMenusEvent extends HomeEvent {}

class ChangeMenusEvent extends HomeEvent {
  final List<Menu> menus;

  ChangeMenusEvent(this.menus);
}
