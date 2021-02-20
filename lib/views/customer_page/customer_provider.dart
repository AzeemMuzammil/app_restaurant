import 'package:app_restaurant/views/customer_page/customer_view.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_bloc.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProvider extends StatelessWidget {
  CustomerProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<CustomerHomeBloc>(
          create: (context) => CustomerHomeBloc(context),
        ),
        // BlocProvider<OrdersBloc>(
        //   create: (context) => OrdersBloc(context),
        // ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(context),
        ),
      ],
      child: CustomerView(),
    );
  }
}
