import 'package:app_restaurant/db/app_user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'customer.g.dart';

abstract class Customer implements AppUser, Built<Customer, CustomerBuilder> {
  static const CUSTOMER_ID = "customerId";

  @nullable
  String get customerId;

  static Serializer<Customer> get serializer => _$customerSerializer;

  @override
  String get id => ref?.id;

  Customer._();

  factory Customer([void Function(CustomerBuilder) updates]) = _$Customer;
}
