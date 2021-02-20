import 'dart:async';
import 'package:app_restaurant/db/order.dart';
import 'package:app_restaurant/db/repos/order_repo.dart';
import 'package:app_restaurant/utils/views/enum_functions.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/orders_event.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/orders_state.dart';
import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final ordersRepo = OrderRepository();

  StreamSubscription _ordersSubscription;

  OrdersBloc(BuildContext context)
      : super(OrdersState(
          loading: false,
          orders: null,
          error: "",
        )) {
    add(FetchOrdersEvent());
  }

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case FetchOrdersEvent:
        yield state.clone(loading: true);
        try {
          _ordersSubscription = ordersRepo
              .query(
            specification: ComplexSpecification(
              [
                OrderBy(Order.ORDER_PLACED_TIME, descending: true),
              ],
            ),
          )
              .listen((orders) {
            add(ChangeOrdersEvent(orders));
          });
        } catch (e) {
          _addErr(e);
        }
        yield state.clone(loading: false);
        break;

      case ChangeOrdersEvent:
        final orders = (event as ChangeOrdersEvent).orders;
        yield state.clone(
          loading: false,
          orders: orders,
        );
        break;

      case UpdateOrderStatusEvent:
        final order = (event as UpdateOrderStatusEvent).order;
        final currentStatus = EnumFunctions.getEnumFromString(
          OrderStatus.values,
          order.orderCurrentStatus,
        );
        String nextStatus = "";
        if (currentStatus == OrderStatus.ORDER_SUBMITTED) {
          nextStatus =
              EnumFunctions.getStringFromEnum(OrderStatus.ORDER_ACCEPTED);
        } else if (currentStatus == OrderStatus.ORDER_ACCEPTED) {
          nextStatus = EnumFunctions.getStringFromEnum(OrderStatus.ORDER_READY);
        }
        await ordersRepo.update(
          item: order,
          mapper: (_) => {
            Order.ORDER_CURRENT_STATUS: nextStatus,
          },
        );
        print("current status");
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    _ordersSubscription.cancel();
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
