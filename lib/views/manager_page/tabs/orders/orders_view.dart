import 'package:app_restaurant/db/order.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/orders_bloc.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/orders_event.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/orders_state.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/widgets/order_widget.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatefulWidget {
  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final customSnackBar = CustomSnackBar(scaffoldKey: _scaffoldKey);
    final bloc = BlocProvider.of<OrdersBloc>(context);
    final scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          child: BlocBuilder<OrdersBloc, OrdersState>(
            buildWhen: (pre, current) => !identical(pre.orders, current.orders),
            builder: (context, state) {
              return state.orders != null
                  ? state.orders.length != 0
                      ? _generateOrders(
                          state.orders,
                          bloc,
                        )
                      : Center(
                          child: Text(
                            "No Orders Available. Please Make an Order.",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                  : Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
            },
          ),
        ),
      ),
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<OrdersBloc, OrdersState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }

  Widget _generateOrders(List<Order> orders, OrdersBloc bloc) {
    List<Widget> widgets = [];
    for (Order order in orders) {
      widgets.add(OrderCard(
        order: order,
        onTap: () {
          bloc.add(UpdateOrderStatusEvent(order));
        },
      ));
      widgets.add(
        SizedBox(
          height: 16,
        ),
      );
    }
    if (widgets.length > 0) {
      widgets.insert(
        0,
        SizedBox(
          height: 24,
        ),
      );
    }
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
