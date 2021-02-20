import 'package:app_restaurant/db/menu.dart';

class CartProduct {
  static const PRODUCT = "product";
  static const QUANTITY = "quantity";

  Menu product;
  double quantity;

  CartProduct({
    this.product,
    this.quantity,
  });
}
