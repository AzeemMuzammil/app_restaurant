import 'package:app_restaurant/views/customer_page/tabs/home/home_bloc.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerHomeProvider extends StatelessWidget {
  CustomerHomeProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerHomeBloc(context),
      child: CustomerHomeView(),
    );
  }
}
