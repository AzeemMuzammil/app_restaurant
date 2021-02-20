import 'package:app_restaurant/db/menu.dart';
import 'package:app_restaurant/utils/db_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/cupertino.dart';

class MenuRepository extends FirebaseRepository<Menu> {
  @override
  Menu fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return Menu(
      (b) => b
        ..ref = snapshot.reference
        ..menuId = data[Menu.MENU_ID]
        ..menuName = data[Menu.MENU_NAME]
        ..description = data[Menu.DESCRIPTION]
        ..pricePerUnit = data[Menu.PRICE_PER_UNIT].toDouble()
        ..imageUrl = data[Menu.IMAGE_URL],
    );
  }

  @override
  Map<String, dynamic> toMap(Menu menu) {
    final Map<String, dynamic> data = {
      Menu.MENU_ID: menu.menuId,
      Menu.MENU_NAME: menu.menuName,
      Menu.DESCRIPTION: menu.description,
      Menu.PRICE_PER_UNIT: menu.pricePerUnit,
      Menu.IMAGE_URL: menu.imageUrl,
    };
    return data;
  }

  @override
  Stream<List<Menu>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.MENU,
    );
  }

  @override
  Future<List<Menu>> querySingle({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.MENU,
    );
  }

  @override
  Future<DocumentReference> add({
    @required Menu item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(item: item, type: DBUtil.MENU);
  }

  @override
  Future<DocumentReference> update({
    @required Menu item,
    String type,
    DocumentReference parent,
    mapper,
  }) {
    return super.update(
      item: item,
      type: DBUtil.MENU,
      mapper: mapper,
    );
  }

  @override
  Future<void> remove({
    Menu item,
  }) {
    return super.remove(
      item: item,
    );
  }
}
