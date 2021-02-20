import 'package:app_restaurant/views/manager_page/tabs/home/add_menus/add_menus_provider.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/home_bloc.dart';
import 'package:app_restaurant/views/manager_page/tabs/home/home_state.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    final customSnackBar = CustomSnackBar(scaffoldKey: _scaffoldKey);
    final scaffold = Scaffold(
        appBar: AppBar(
          title: Text("Manager's Home"),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: Container(
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (pre, current) =>
                  !identical(pre.menues, current.menues),
              builder: (context, state) {
                return state.menues != null
                    ? state.menues.length != 0
                        ? ListView.builder(
                            itemCount: state.menues.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = state.menues[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddProductProvider(
                                            isEditMode: true,
                                            product: item,
                                          )));
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(8.0),
                                  title: Text(item.menuName),
                                  subtitle: Text(item.description),
                                  leading: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                  trailing: Text(
                                    item.pricePerUnit.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Center(
                            child: Text(
                              "No Menus Available. Please Add.",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                    : Container(
                        child: Center(child: CircularProgressIndicator()),
                      );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddProductProvider()));
          },
          child: Icon(
            Icons.add,
          ),
        ));
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
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
