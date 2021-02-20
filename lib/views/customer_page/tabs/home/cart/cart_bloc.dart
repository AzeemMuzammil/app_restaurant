import 'dart:async';
import 'dart:math';

import 'package:app_restaurant/db/order.dart';
import 'package:app_restaurant/db/repos/order_repo.dart';
import 'package:app_restaurant/utils/views/enum_functions.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_event.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_state.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/models/cart_product_model.dart';
import 'package:app_restaurant/views/root_page/root_page.dart' hide ErrorEvent;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final _orderRepo = OrderRepository();

  final RootBloc _rootBloc;
  // final OrdersBloc _ordersBloc;

  CartBloc(BuildContext context)
      : _rootBloc = BlocProvider.of<RootBloc>(context),
        // _ordersBloc = BlocProvider.of<OrdersBloc>(context),
        super(
          CartState(
            loading: false,
            cartProducts: [],
            subTotal: 0,
            orderPlaced: false,
            error: "",
          ),
        );

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case ProductAddedToCartEvent:
        final newCartProduct = (event as ProductAddedToCartEvent).cartProduct;
        final cartProducts = List<CartProduct>.from(state.cartProducts);
        bool inserted = false;
        for (CartProduct cartProduct in cartProducts) {
          if (newCartProduct.product.menuId == cartProduct.product.menuId) {
            final index = cartProducts.indexOf(cartProduct);
            cartProducts.removeAt(index);
            cartProducts.insert(index, newCartProduct);
            inserted = true;
          }
        }
        if (!inserted) cartProducts.add(newCartProduct);
        add(ChangeCartProductsEvent(cartProducts));
        break;

      case DeletePressedEvent:
        final removeCartProduct = (event as DeletePressedEvent).cartProduct;
        final cartProducts = List<CartProduct>.from(state.cartProducts);
        cartProducts.remove(removeCartProduct);
        add(ChangeCartProductsEvent(cartProducts));
        break;

      case ChangeCartProductsEvent:
        final cartProducts = (event as ChangeCartProductsEvent).cartProducts;
        add(CalculateTotalEvent(cartProducts));
        yield state.clone(cartProducts: cartProducts);
        break;

      case CalculateTotalEvent:
        final cartProducts = (event as CalculateTotalEvent).cartProducts;
        final subTotal = _calulateSubTotal(cartProducts);
        yield state.clone(subTotal: subTotal);
        break;

      case PlaceOrderPressedEvent:
        List<String> orderedProducts = [];
        state.cartProducts.forEach((cartProduct) {
          orderedProducts.add(
            "${cartProduct.quantity.toInt()} x ${cartProduct.product.menuName}",
          );
        });
        String orderedUserName =
            "${_rootBloc.state.user.firstName} ${_rootBloc.state.user.lastName}";
        Order newOrder = Order(
          (b) => b
            ..orderID = Unique.calculateOrderID()
            ..orderedUserRef = _rootBloc.state.user.ref
            ..orderedUserName = orderedUserName
            ..orderPlacedTimeServerTS = FieldValue.serverTimestamp()
            ..orderCurrentStatus =
                EnumFunctions.getStringFromEnum(OrderStatus.ORDER_SUBMITTED)
            ..orderedProducts = orderedProducts
            ..orderSubTotal = state.subTotal,
        );
        try {
          yield state.clone(loading: true);
          await _orderRepo.add(item: newOrder);
          yield state.clone(loading: false);
          add(OrderSussfullyPlacedEvent());
        } catch (e) {
          _addErr(e);
        }
        break;

      case OrderSussfullyPlacedEvent:
        yield state.clone(orderPlaced: true);
        yield state.clone(
          cartProducts: [],
          subTotal: 0,
          orderPlaced: false,
        );
        break;
    }
  }

  double _calulateSubTotal(List<CartProduct> cartProducts) {
    double subTotal = 0;
    cartProducts.forEach((cartProduct) {
      final product = cartProduct.product;
      final costPerProduct = product.pricePerUnit * cartProduct.quantity;
      subTotal += costPerProduct;
    });
    return subTotal;
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  void _addErr(e) {
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}

class Unique {
  static String calculateOrderID() {
    /// [OrderID] will be calculated based on [local timestamp].
    final currentTimestampInt = Timestamp.now().seconds;
    return "#${_intToCustom(currentTimestampInt)}";
  }

  static String _intToCustom(int value) {
    Map<int, String> intToCustomMap = {
      0: "0",
      1: "1",
      2: "2",
      3: "3",
      4: "4",
      5: "5",
      6: "6",
      7: "7",
      8: "8",
      9: "9",
      10: "A",
      11: "B",
      12: "C",
      13: "D",
      14: "E",
      15: "F",
      16: "G",
      17: "H",
      18: "I",
      19: "J",
      20: "K",
      21: "L",
      22: "M",
      23: "N",
      24: "O",
      25: "P",
      26: "Q",
      27: "R",
      28: "S",
      29: "T",
      30: "U",
      31: "V",
      32: "W",
      33: "X",
      34: "Y",
      35: "Z",
    };
    List<String> custom = [];
    while (value > 0) {
      int remainder = value % 36;
      value = (value / 36).floor();
      custom.insert(0, intToCustomMap[remainder]);
    }

    Random rng = Random();

    if (custom.length > 8) {
      while (custom.length > 8) {
        final newIndex = rng.nextInt(custom.length - 2);
        custom.removeAt(newIndex);
      }
    } else if (custom.length < 8) {
      while (custom.length < 8) {
        final newIndex = rng.nextInt(custom.length - 2);
        custom.insert(newIndex, rng.nextInt(9).toString());
      }
    }
    return custom.join("").trim();
  }
}
