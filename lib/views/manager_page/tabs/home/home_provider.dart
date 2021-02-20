import 'package:app_restaurant/views/manager_page/tabs/home/home_view.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProvider extends StatelessWidget {
  HomeProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context),
      child: HomeView(),
    );
  }
}
