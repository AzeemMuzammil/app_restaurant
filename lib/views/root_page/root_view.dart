import 'package:app_restaurant/db/customer.dart';
import 'package:app_restaurant/db/manager.dart';
import 'package:app_restaurant/views/auth_page/auth_page.dart';
import 'package:app_restaurant/views/customer_page/customer_provider.dart';
import 'package:app_restaurant/views/manager_page/manager_view.dart';
import 'package:app_restaurant/views/root_page/root_page.dart';
import 'package:app_restaurant/views/support_page/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  static final loadingView = LoadingView();
  static final authView = AuthProvider();
  static final customerView = CustomerProvider();
  static final managerView = ManagerView();

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<RootBloc, RootState>(
        buildWhen: (pre, current) =>
            pre.page != current.page ||
            pre.user?.ref?.path != current.user?.ref?.path,
        builder: (context, state) {
          if (state.page == RootState.AUTH_PAGE) {
            return authView;
          } else if (state.page == RootState.HOME_PAGE) {
            if (state.user is Customer) {
              return customerView;
            } else if (state.user is Manager) {
              return managerView;
            }
          }
          return loadingView;
        },
      ),
    );

    return scaffold;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
