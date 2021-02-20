import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class ErrorEvent extends AuthEvent {
  final String error;

  ErrorEvent(this.error);
}

class LoginPressedEvent extends AuthEvent {
  final bool isManager;
  final String email;
  final String password;

  LoginPressedEvent(this.isManager, this.email, this.password);
}

class RegisterPressedEvent extends AuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  RegisterPressedEvent(
      this.email, this.firstName, this.lastName, this.password);
}
