import 'package:app_restaurant/db/menu.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_bloc.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductProvider extends StatelessWidget {
  final bool isEditMode;
  final Menu product;
  AddProductProvider({
    Key key,
    this.isEditMode = false,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc(context),
      child: AddProductView(
        isEditMode: isEditMode,
        product: product,
      ),
    );
  }
}
