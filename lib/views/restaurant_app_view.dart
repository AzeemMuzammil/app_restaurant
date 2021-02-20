import 'package:app_restaurant/views/root_page/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantApp extends StatelessWidget {
  static final rootView = RootView();

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mcmillan Restaurant",
      home: rootView,
    );

    return BlocProvider(
      create: (context) => RootBloc(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: materialApp,
      ),
    );
  }
}
