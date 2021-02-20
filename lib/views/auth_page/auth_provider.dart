import 'package:app_restaurant/views/auth_page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthProvider extends BlocProvider<AuthBloc> {
  AuthProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => AuthBloc(context),
          child: AuthView(),
        );
}
