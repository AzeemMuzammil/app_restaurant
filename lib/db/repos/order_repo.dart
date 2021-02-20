import 'package:app_restaurant/db/order.dart';
import 'package:app_restaurant/utils/db_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/cupertino.dart';

class OrderRepository extends FirebaseRepository<Order> {
  static OrderRepository _orderRepository;

  factory OrderRepository() {
    if (_orderRepository == null) {
      _orderRepository = OrderRepository._internal();
    }
    return _orderRepository;
  }

  OrderRepository._internal();

  @override
  Order fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return Order(
      (b) => b
        ..ref = snapshot.reference
        ..orderID = data[Order.ORDER_ID]
        ..orderedUserRef = data[Order.ORDERED_USER_REF]
        ..orderedUserName = data[Order.ORDERED_USER_NAME]
        ..orderPlacedTime = data[Order.ORDER_PLACED_TIME]
        ..orderCurrentStatus = data[Order.ORDER_CURRENT_STATUS]
        ..orderedProducts =
            List<String>.from(data[Order.ORDERED_PRODUCTS] ?? [])
        ..orderSubTotal = data[Order.ORDER_SUB_TOTAL].toDouble(),
    );
  }

  @override
  Map<String, dynamic> toMap(Order order) {
    final Map<String, dynamic> data = {
      Order.ORDER_ID: order.orderID,
      Order.ORDERED_USER_REF: order.orderedUserRef,
      Order.ORDERED_USER_NAME: order.orderedUserName,
      Order.ORDER_PLACED_TIME: order.orderPlacedTimeServerTS,
      Order.ORDER_CURRENT_STATUS: order.orderCurrentStatus,
      Order.ORDERED_PRODUCTS: order.orderedProducts,
      Order.ORDER_SUB_TOTAL: order.orderSubTotal,
    };
    return data;
  }

  @override
  Stream<List<Order>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.ORDER,
    );
  }

  @override
  Future<List<Order>> querySingle({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.ORDER,
    );
  }

  @override
  Future<DocumentReference> add({
    @required Order item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(item: item, type: DBUtil.ORDER);
  }

  @override
  Future<DocumentReference> update({
    @required Order item,
    String type,
    DocumentReference parent,
    mapper,
  }) {
    return super.update(
      item: item,
      type: DBUtil.ORDER,
      mapper: mapper,
    );
  }

  @override
  Future<void> remove({
    Order item,
  }) {
    return super.remove(
      item: item,
    );
  }
}
