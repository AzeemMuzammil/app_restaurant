import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

part 'menu.g.dart';

abstract class Menu implements DBModelI, Built<Menu, MenuBuilder> {
  static const MENU_ID = "menuId";
  static const MENU_NAME = "menuName";
  static const DESCRIPTION = "description";
  static const PRICE_PER_UNIT = "pricePerUnit";
  static const IMAGE_URL = "imageUrl";

  @nullable
  String get menuId;

  @nullable
  String get menuName;

  @nullable
  String get description;

  @nullable
  double get pricePerUnit;

  @nullable
  String get imageUrl;

  @override
  String get id => ref?.id;

  Menu._();

  factory Menu([void Function(MenuBuilder) updates]) = _$Menu;
}
