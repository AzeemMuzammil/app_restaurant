import 'package:app_restaurant/views/customer_page/tabs/orders/orders_bloc.dart';
import 'package:app_restaurant/views/customer_page/tabs/orders/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOrdersProvider extends StatelessWidget {
  CustomerOrdersProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerOrdersBloc(context),
      child: CustomerOrdersView(),
    );
  }
}
