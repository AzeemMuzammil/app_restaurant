import 'package:app_restaurant/db/app_user.dart';
import 'package:app_restaurant/db/customer.dart';
import 'package:app_restaurant/db/manager.dart';
import 'package:app_restaurant/utils/db_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/cupertino.dart';

class UserRepository extends FirebaseRepository<AppUser> {
  @override
  AppUser fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    if (data[AppUser.USER_TYPE] == (Customer).toString()) {
      return Customer(
        (b) => b
          ..ref = snapshot.reference
          ..userId = data[AppUser.USER_ID]
          ..emailAddress = data[AppUser.EMAIL_ADDRESS]
          ..firstName = data[AppUser.FIRST_NAME]
          ..lastName = data[AppUser.LAST_NAME]
          ..customerId = data[Customer.CUSTOMER_ID],
      );
    } else if (data[AppUser.USER_TYPE] == (Manager).toString()) {
      return Manager(
        (b) => b
          ..ref = snapshot.reference
          ..userId = data[AppUser.USER_ID]
          ..emailAddress = data[AppUser.EMAIL_ADDRESS]
          ..firstName = data[AppUser.FIRST_NAME]
          ..lastName = data[AppUser.LAST_NAME]
          ..managerId = data[Manager.MANAGER_ID],
      );
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap(AppUser user) {
    final Map<String, dynamic> data = {
      AppUser.USER_ID: user.userId,
      AppUser.EMAIL_ADDRESS: user.emailAddress,
      AppUser.FIRST_NAME: user.firstName,
      AppUser.LAST_NAME: user.lastName,
    };

    if (user is Customer) {
      data[AppUser.USER_TYPE] = (Customer).toString();
      data[Customer.CUSTOMER_ID] = user.customerId;
    } else if (user is Manager) {
      data[AppUser.USER_TYPE] = (Manager).toString();
      data[Manager.MANAGER_ID] = user.managerId;
    }
    return data;
  }

  @override
  Stream<List<AppUser>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.USER,
    );
  }

  @override
  Future<List<AppUser>> querySingle({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.USER,
    );
  }

  @override
  Future<DocumentReference> add({
    @required AppUser item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(
      item: item,
      type: DBUtil.USER,
    );
  }

  @override
  Future<void> addList({
    @required Iterable<AppUser> items,
    String type,
    DocumentReference parent,
  }) {
    return super.addList(
      items: items,
      type: DBUtil.USER,
    );
  }

  @override
  Future<DocumentReference> update({
    @required AppUser item,
    String type,
    DocumentReference parent,
    mapper,
  }) {
    return super.update(
      item: item,
      type: DBUtil.USER,
      mapper: mapper,
    );
  }

  @override
  Future<void> removeList({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.removeList(
      specification: specification,
      type: DBUtil.USER,
      parent: parent,
    );
  }
}
