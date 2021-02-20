import 'dart:async';
import 'package:app_restaurant/db/order.dart';
import 'package:app_restaurant/db/repos/order_repo.dart';
import 'package:app_restaurant/views/customer_page/tabs/orders/orders_event.dart';
import 'package:app_restaurant/views/customer_page/tabs/orders/orders_state.dart';
import 'package:app_restaurant/views/root_page/root_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOrdersBloc
    extends Bloc<CustomerOrdersEvent, CustomerOrdersState> {
  final ordersRepo = OrderRepository();

  final RootBloc _rootBloc;

  StreamSubscription _ordersSubscription;

  CustomerOrdersBloc(BuildContext context)
      : _rootBloc = BlocProvider.of<RootBloc>(context),
        super(CustomerOrdersState(
          loading: false,
          orders: null,
          error: "",
        )) {
    add(FetchOrdersEvent());
  }

  @override
  Stream<CustomerOrdersState> mapEventToState(
      CustomerOrdersEvent event) async* {
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
                ComplexWhere(
                  Order.ORDERED_USER_REF,
                  isEqualTo: _rootBloc.state.user.ref,
                ),
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
