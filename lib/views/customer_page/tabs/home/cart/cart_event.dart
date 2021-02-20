import 'package:app_restaurant/views/customer_page/tabs/home/cart/models/cart_product_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CartEvent {}

class ErrorEvent extends CartEvent {
  final String error;

  ErrorEvent(this.error);
}

class ProductAddedToCartEvent extends CartEvent {
  final CartProduct cartProduct;

  ProductAddedToCartEvent(this.cartProduct);
}

class DeletePressedEvent extends CartEvent {
  final CartProduct cartProduct;

  DeletePressedEvent(this.cartProduct);
}

class PlaceOrderPressedEvent extends CartEvent {}

class OrderSussfullyPlacedEvent extends CartEvent {}

class ChangeCartProductsEvent extends CartEvent {
  final List<CartProduct> cartProducts;

  ChangeCartProductsEvent(this.cartProducts);
}

class CalculateTotalEvent extends CartEvent {
  final List<CartProduct> cartProducts;

  CalculateTotalEvent(this.cartProducts);
}
