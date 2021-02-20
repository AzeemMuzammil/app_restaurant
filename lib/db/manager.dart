import 'package:app_restaurant/db/app_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'manager.g.dart';

abstract class Manager implements AppUser, Built<Manager, ManagerBuilder> {
  static const MANAGER_ID = "managerId";

  @nullable
  String get managerId;

  static Serializer<Manager> get serializer => _$managerSerializer;

  @override
  String get id => ref?.id;

  Manager._();

  factory Manager([void Function(ManagerBuilder) updates]) = _$Manager;
}
