import 'package:built_value/built_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

part 'app_user.g.dart';

@BuiltValue(instantiable: false)
abstract class AppUser implements DBModelI {
  static const USER_ID = "userId";
  static const EMAIL_ADDRESS = "emailAddress";
  static const FIRST_NAME = "firstName";
  static const LAST_NAME = "lastName";
  static const USER_TYPE = "userType";

  @nullable
  String get userId;

  @nullable
  String get emailAddress;

  @nullable
  String get firstName;

  @nullable
  String get lastName;

  @override
  String get id => ref?.id;
}
