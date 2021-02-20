import 'dart:io';

import 'package:app_restaurant/db/menu.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AddProductEvent {}

class ErrorEvent extends AddProductEvent {
  final String error;

  ErrorEvent(this.error);
}

class AddButtonPressedEvent extends AddProductEvent {
  final String id;
  final String name;
  final String description;
  final String pricePerUint;
  final File image;

  AddButtonPressedEvent(
    this.id,
    this.name,
    this.description,
    this.pricePerUint,
    this.image,
  );
}

class UpdateButtonPressedEvent extends AddProductEvent {
  final String id;
  final String name;
  final String description;
  final String pricePerUint;
  final File image;
  final Menu product;

  UpdateButtonPressedEvent(
    this.id,
    this.name,
    this.description,
    this.pricePerUint,
    this.image,
    this.product,
  );
}

class DeleteButtonPressedEvent extends AddProductEvent {
  final Menu product;

  DeleteButtonPressedEvent(this.product);
}
