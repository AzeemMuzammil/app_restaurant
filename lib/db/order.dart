import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

part 'order.g.dart';

enum OrderStatus {
  ORDER_SUBMITTED,
  ORDER_ACCEPTED,
  ORDER_READY,
}

abstract class Order implements DBModelI, Built<Order, OrderBuilder> {
  static const ORDER_ID = "orderID";
  static const ORDERED_USER_REF = "orderedUserRef";
  static const ORDERED_USER_NAME = "orderedUserName";
  static const ORDER_PLACED_TIME = "orderPlacedTime";
  static const ORDER_CURRENT_STATUS = "orderCurrentStatus";
  static const ORDERED_PRODUCTS = "orderedProducts";
  static const ORDER_SUB_TOTAL = "orderSubTotal";

  @nullable
  String get orderID;

  @nullable
  DocumentReference get orderedUserRef;

  @nullable
  String get orderedUserName;

  @nullable
  Timestamp get orderPlacedTime;

  @nullable
  FieldValue get orderPlacedTimeServerTS;

  @nullable
  String get orderCurrentStatus;

  @nullable
  List<String> get orderedProducts;

  @nullable
  double get orderSubTotal;

  @override
  String get id => ref?.id;

  Order._();

  factory Order([void Function(OrderBuilder) updates]) = _$Order;

  static String orderStatusToDisplayString(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.ORDER_SUBMITTED:
        return "Order submitted";
      case OrderStatus.ORDER_ACCEPTED:
        return "Order accepted";
      case OrderStatus.ORDER_READY:
        return "Order ready";
      default:
        return "Order status unknown";
    }
  }
}
