import 'package:app_restaurant/views/manager_page/tabs/orders/orders_bloc.dart';
import 'package:app_restaurant/views/manager_page/tabs/orders/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersProvider extends StatelessWidget {
  OrdersProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersBloc(context),
      child: OrdersView(),
    );
  }
}
