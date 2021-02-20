import 'dart:async';
import 'package:app_restaurant/db/menu.dart';
import 'package:app_restaurant/db/repos/menu_repo.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_event.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final storage = FirebaseStorage.instance;
  final productRepo = MenuRepository();
  AddProductBloc(BuildContext context)
      : super(AddProductState(
          loading: false,
          inserted: false,
          error: "",
        ));

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error, loading: false);
        print(error);
        break;

      case AddButtonPressedEvent:
        if (state.loading) {
          break;
        }
        yield state.clone(loading: true);
        final e = (event as AddButtonPressedEvent);
        final id = e.id;
        final name = e.name;
        final description = e.description;
        final pricePerUnit = e.pricePerUint;
        final image = e.image;
        final imageStoreID = Timestamp.now().seconds.toString();
        if (image == null ||
            ["", null].contains(id) ||
            ["", null].contains(name) ||
            ["", null].contains(pricePerUnit)) {
          add(ErrorEvent("cannot be null"));
        } else {
          try {
            final pricePerUnitDouble = double.parse(pricePerUnit);
            final Reference ref = storage.ref();
            final UploadTask addImg =
                ref.child("products/$imageStoreID").putFile(image);
            final String downloadUrl =
                await (await addImg).ref.getDownloadURL();
            final product = Menu(
              (b) => b
                ..menuId = id
                ..menuName = name
                ..description = description
                ..pricePerUnit = pricePerUnitDouble
                ..imageUrl = downloadUrl.toString(),
            );
            await productRepo.add(item: product);
            yield state.clone(loading: false, inserted: true);
          } catch (e) {
            add(ErrorEvent(
                "text cannot be in number field or ${e.toString()}"));
          }
        }
        break;

      case DeleteButtonPressedEvent:
        if (state.loading) {
          break;
        }
        yield state.clone(loading: true);
        final product = (event as DeleteButtonPressedEvent).product;
        await productRepo.remove(item: product);
        final Reference ref = storage.refFromURL(product.imageUrl);
        await ref.delete();
        yield state.clone(loading: false, inserted: true);
        break;

      case UpdateButtonPressedEvent:
        if (state.loading) {
          break;
        }
        yield state.clone(loading: true);
        final e = (event as UpdateButtonPressedEvent);
        final id = e.id;
        final name = e.name;
        final description = e.description;
        final pricePerUnit = e.pricePerUint;
        final image = e.image;
        final imageStoreID = Timestamp.now().seconds.toString();
        final product = e.product;
        try {
          final pricePerUnitDouble = double.parse(pricePerUnit);

          String newImageDownloadString;

          if (image != null) {
            final Reference delRef = storage.refFromURL(product.imageUrl);
            await delRef.delete();
            final Reference ref = storage.ref();
            final UploadTask addImg =
                ref.child("products/$imageStoreID").putFile(image);
            newImageDownloadString = await (await addImg).ref.getDownloadURL();
          }
          await productRepo.update(
            item: product,
            mapper: (_) => {
              Menu.MENU_ID: id,
              Menu.MENU_NAME: name,
              Menu.DESCRIPTION: description,
              Menu.PRICE_PER_UNIT: pricePerUnitDouble,
              Menu.IMAGE_URL:
                  image == null ? product.imageUrl : newImageDownloadString,
            },
          );
          yield state.clone(inserted: true, loading: false);
        } catch (e) {
          add(ErrorEvent("text cannot be in number field"));
        }
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  void _addErr(e) {
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
