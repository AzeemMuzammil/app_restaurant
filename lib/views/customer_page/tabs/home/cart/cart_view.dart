import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_bloc.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_event.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/cart_state.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/cart/models/cart_product_model.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final customSnackBar = CustomSnackBar(scaffoldKey: _scaffoldKey);
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final scaffold = Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (pre, current) =>
            !identical(pre.cartProducts, current.cartProducts),
        builder: (context, state) {
          return state.cartProducts.length == 0
              ? Center(
                  child: Text(
                    "Your shopping bag is empty. Add anything to buy.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: state.cartProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = state.cartProducts[index];
                            return GestureDetector(
                              onTap: () async {
                                _settingModalBottomSheet(
                                  context,
                                  cartBloc,
                                  item,
                                );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8.0),
                                title: Text(item.product.menuName),
                                subtitle: Text(
                                  item.product.pricePerUnit.toStringAsFixed(2),
                                ),
                                leading: Text(
                                  "  ${item.quantity.toInt().toString()}  x ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Text(
                                  "${(item.product.pricePerUnit * item.quantity).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                        SizedBox(
                          height: 180,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Subtotal(${state.cartProducts.length} items):",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  BlocBuilder<CartBloc, CartState>(
                                    buildWhen: (pre, current) =>
                                        pre.subTotal != current.subTotal,
                                    builder: (context, state) {
                                      return Text(
                                        "Rs.${state.subTotal.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "Total:",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  BlocBuilder<CartBloc, CartState>(
                                    buildWhen: (pre, current) =>
                                        pre.subTotal != current.subTotal,
                                    builder: (context, state) {
                                      return Text(
                                        "Rs.${(state.subTotal).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              ButtonTheme(
                                height: 48,
                                minWidth: 180,
                                child: FlatButton(
                                  splashColor: Colors.transparent,
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Place Order",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    cartBloc.add(PlaceOrderPressedEvent());
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<CartBloc, CartState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error != "") {
              customSnackBar?.showLoadingSnackBar();
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<CartBloc, CartState>(
          listenWhen: (pre, current) => pre.loading != current.loading,
          listener: (context, state) {
            if (state.loading) {
              customSnackBar?.showLoadingSnackBar();
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<CartBloc, CartState>(
          listenWhen: (pre, current) => pre.orderPlaced != current.orderPlaced,
          listener: (context, state) {
            if (state.orderPlaced) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        ),
      ],
      child: scaffold,
    );
  }

  void _settingModalBottomSheet(
      BuildContext context, CartBloc cartBloc, CartProduct cartProduct) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0)),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Remove",
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Are you sure you want to remove ${cartProduct.product.menuName}?",
                ),
                Expanded(
                  child: Container(),
                ),
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Row(
                    children: [
                      ButtonTheme(
                        height: 40,
                        minWidth: 100,
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "No",
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ButtonTheme(
                        height: 40,
                        minWidth: 100,
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.red[300],
                          onPressed: () {
                            Navigator.of(context).pop();
                            cartBloc.add(DeletePressedEvent(cartProduct));
                          },
                          child: Text(
                            "Yes",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
