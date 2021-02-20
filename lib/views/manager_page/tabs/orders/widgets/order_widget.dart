import 'package:app_restaurant/db/order.dart';
import 'package:app_restaurant/utils/date_util.dart';
import 'package:app_restaurant/utils/views/enum_functions.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderCard extends Container {
  final Order order;
  final VoidCallback onTap;
  OrderCard({
    Key key,
    @required this.order,
    @required this.onTap,
  }) : super(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1,
                color: Colors.grey[400],
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                ),
                height: 20,
                alignment: Alignment.centerLeft,
                color: Colors.grey[200],
                child: Text(
                  _orderDateTime(order.orderPlacedTime),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                ),
                child: _orderStatus(order.orderCurrentStatus),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 44,
                  right: 24,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTotalPrice(order),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Order-ID: ${order.orderID}",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey[400],
                    ),
                    _generatePurchaseItems(order.orderedProducts),
                    SizedBox(
                      height: 10,
                    ),
                    _generateBottomButtons(order.orderCurrentStatus, onTap),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[400],
              ),
            ],
          ),
        );

  static String _getTotalPrice(Order order) {
    return "Rs.${(order.orderSubTotal).toStringAsFixed(2)}";
  }

  static Widget _generatePurchaseItems(List<String> orderItems) {
    List<Widget> widgets = [];
    orderItems.forEach((product) {
      widgets.add(
        Row(
          children: [
            Text(
              product,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
      widgets.add(
        SizedBox(
          height: 6,
        ),
      );
    });
    if (widgets.length > 0) {
      widgets.insert(
        0,
        SizedBox(
          height: 10,
        ),
      );
      widgets.removeLast();
    }
    return Column(
      children: widgets,
    );
  }

  static String _orderDateTime(Timestamp timestamp) {
    if (timestamp == null) {
      return "Unknown";
    } else {
      final dateTime = timestamp.toDate();
      final day = dateTime.day;
      final suffix = DateUtil.getDaySuffix(day);
      final formatter = DateFormat("d'$suffix' MMMM y 'at' h:m a");
      return formatter.format(dateTime);
    }
  }

  static Row _orderStatus(String orderStatus) {
    OrderStatus status =
        EnumFunctions.getEnumFromString(OrderStatus.values, orderStatus);
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Colors.blue,
          size: 20,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          Order.orderStatusToDisplayString(status),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  static Column _generateBottomButtons(String orderStatus, VoidCallback onTap) {
    OrderStatus status =
        EnumFunctions.getEnumFromString(OrderStatus.values, orderStatus);
    return Column(
      children: status == OrderStatus.ORDER_READY || status == null
          ? []
          : [
              Container(
                height: 1,
                color: Colors.grey[400],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ButtonTheme(
                  height: 28,
                  minWidth: 160,
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status == OrderStatus.ORDER_SUBMITTED
                          ? "Accept Order"
                          : "Order is Ready",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    onPressed: onTap,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
    );
  }
}
