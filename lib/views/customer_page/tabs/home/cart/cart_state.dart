import 'package:app_restaurant/views/customer_page/tabs/home/cart/models/cart_product_model.dart';
import 'package:flutter/material.dart';

@immutable
class CartState {
  final String error;
  final List<CartProduct> cartProducts;
  final double subTotal;
  final bool orderPlaced;
  final bool loading;

  CartState({
    @required this.error,
    @required this.cartProducts,
    @required this.subTotal,
    @required this.orderPlaced,
    @required this.loading,
  });

  CartState clone({
    String error,
    List<CartProduct> cartProducts,
    double subTotal,
    bool orderPlaced,
    bool loading,
  }) {
    return CartState(
      error: error ?? this.error,
      cartProducts: cartProducts ?? this.cartProducts,
      subTotal: subTotal ?? this.subTotal,
      orderPlaced: orderPlaced ?? this.orderPlaced,
      loading: loading ?? this.loading,
    );
  }
}
