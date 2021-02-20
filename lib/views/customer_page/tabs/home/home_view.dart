import 'package:app_restaurant/utils/views/input_dialog.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_bloc.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_event.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_view.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/models/cart_product_model.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/home_bloc.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/home_state.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerHomeView extends StatefulWidget {
  @override
  _CustomerHomeViewState createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CustomerHomeBloc>(context);
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final customSnackBar = CustomSnackBar(scaffoldKey: _scaffoldKey);
    final scaffold = Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: Container(
            child: BlocBuilder<CustomerHomeBloc, CustomerHomeState>(
              buildWhen: (pre, current) =>
                  !identical(pre.menues, current.menues),
              builder: (context, state) {
                return state.menues != null
                    ? state.menues.length != 0
                        ? ListView.builder(
                            itemCount: state.menues.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = state.menues[index];
                              return GestureDetector(
                                onTap: () async {
                                  final quantity = await CustomInputDialog.show(
                                    context,
                                    "Quantity",
                                  );
                                  final intQuantity = int.tryParse(quantity);
                                  final product = CartProduct(
                                    product: item,
                                    quantity: intQuantity.toDouble(),
                                  );
                                  if (intQuantity != null) {
                                    cartBloc
                                        .add(ProductAddedToCartEvent(product));
                                  }
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(8.0),
                                  title: Text(item.menuName),
                                  subtitle: Text(item.description),
                                  leading: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                  trailing: Text(
                                    item.pricePerUnit.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No Menus Available. Please Try Later.",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: cartBloc,
                  child: CartView(),
                ),
              ),
            );
          },
          child: Icon(
            Icons.shopping_basket,
          ),
        ));
    return MultiBlocListener(
      listeners: [
        BlocListener<CustomerHomeBloc, CustomerHomeState>(
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
}
