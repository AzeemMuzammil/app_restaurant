import 'dart:io';
import 'package:app_restaurant/db/menu.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_bloc.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_event.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_state.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends StatefulWidget {
  final bool isEditMode;
  final Menu product;
  AddProductView({
    Key key,
    @required this.isEditMode,
    @required this.product,
  }) : super(key: key);
  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _idController;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  File _image;

  @override
  void initState() {
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    if (widget.isEditMode) {
      _idController.text = widget.product.menuId;
      _nameController.text = widget.product.menuName;
      _descriptionController.text = widget.product.description;
      _priceController.text = widget.product.pricePerUnit.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future getImageFromGalary() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null)
      setState(() {
        _image = File(pickedImage.path);
      });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddProductBloc>(context);
    final customSnackBar = CustomSnackBar(scaffoldKey: _scaffoldKey);
    final scaffold = Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 36,
                    left: 36,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Menu ID",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 36,
                    right: 36,
                    top: 8,
                  ),
                  child: TextField(
                    controller: _idController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 36,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Menu Name",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 36,
                    right: 36,
                    top: 8,
                  ),
                  child: TextField(
                    controller: _nameController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 36,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 36,
                    right: 36,
                    top: 8,
                  ),
                  child: TextField(
                    controller: _descriptionController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 36,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price per unit",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 36,
                    right: 36,
                    top: 8,
                  ),
                  child: TextField(
                    controller: _priceController,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    getImageFromGalary();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    child: _image == null
                        ? widget.isEditMode
                            ? [null, ""].contains(widget.product.imageUrl)
                                ? Text(
                                    "Click to pick an Image",
                                    textAlign: TextAlign.center,
                                  )
                                : Image(
                                    image:
                                        NetworkImage(widget.product.imageUrl))
                            : Text(
                                "Click to pick an Image",
                                textAlign: TextAlign.center,
                              )
                        : Container(
                            height: 100,
                            width: 100,
                            child: Image.file(_image),
                          ),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                ButtonTheme(
                  height: 40,
                  minWidth: 185,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    splashColor: Colors.transparent,
                    color: Colors.green,
                    onPressed: () {
                      !widget.isEditMode
                          ? bloc.add(
                              AddButtonPressedEvent(
                                _idController.text,
                                _nameController.text,
                                _descriptionController.text,
                                _priceController.text,
                                _image,
                              ),
                            )
                          : bloc.add(
                              UpdateButtonPressedEvent(
                                _idController.text,
                                _nameController.text,
                                _descriptionController.text,
                                _priceController.text,
                                _image,
                                widget.product,
                              ),
                            );
                    },
                    child: Text(
                      !widget.isEditMode ? "Add" : "Update",
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                Visibility(
                  visible: widget.isEditMode,
                  child: ButtonTheme(
                    height: 40,
                    minWidth: 185,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      splashColor: Colors.transparent,
                      color: Colors.redAccent,
                      onPressed: () {
                        bloc.add(DeleteButtonPressedEvent(widget.product));
                      },
                      child: Text(
                        "Delete",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AddProductBloc, AddProductState>(
          listenWhen: (pre, current) => pre.inserted != current.inserted,
          listener: (context, state) {
            if (state.inserted) {
              Navigator.of(context).pop();
            }
            return;
          },
        ),
        BlocListener<AddProductBloc, AddProductState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error != "") {
              customSnackBar?.showLoadingSnackBar();
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<AddProductBloc, AddProductState>(
          listenWhen: (pre, current) => pre.loading != current.loading,
          listener: (context, state) {
            if (state.loading) {
              customSnackBar?.showLoadingSnackBar();
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
