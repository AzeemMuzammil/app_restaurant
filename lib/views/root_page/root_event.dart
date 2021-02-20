import 'package:app_restaurant/db/app_user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RootEvent {}

class ErrorEvent extends RootEvent {
  final String error;

  ErrorEvent(this.error);
}

class HandleUserEvent extends RootEvent {}

class HandleLoggedInUserEvent extends RootEvent {
  final AppUser loggedInUser;

  HandleLoggedInUserEvent(this.loggedInUser);
}

class LogoutEvent extends RootEvent {}

class FetchLoggedInUserEvent extends RootEvent {
  final AppUser user;

  FetchLoggedInUserEvent(this.user);
}

class ChangeLoggedInUserEvent extends RootEvent {
  final AppUser user;

  ChangeLoggedInUserEvent(this.user);
}

class GoHomeEvent extends RootEvent {}
