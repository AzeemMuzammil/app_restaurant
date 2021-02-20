import 'package:app_restaurant/views/customer_page/tabs/about/about_view.dart';
import 'package:app_restaurant/views/customer_page/tabs/home/home_provider.dart';
import 'package:app_restaurant/views/customer_page/tabs/orders/orders_provider.dart';
import 'package:flutter/material.dart';

class CustomerView extends StatelessWidget {
  static final tabBarKey = new GlobalKey<_MainCustomerViewState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainCustomerView(
        key: tabBarKey,
      ),
    );
  }
}

class MainCustomerView extends StatefulWidget {
  MainCustomerView({
    Key key,
  }) : super(key: key);
  @override
  _MainCustomerViewState createState() => _MainCustomerViewState();
}

class _MainCustomerViewState extends State<MainCustomerView>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.addListener(handleTabSelection);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SafeArea(child: _buildBody(context)),
      bottomNavigationBar: Container(
        height: 48 + bottomSafeArea,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 12,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: _buildTabBar(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: tabController,
      children: <Widget>[
        CustomerHomeProvider(),
        CustomerOrdersProvider(),
        AboutView(),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: <Widget>[
        Tab(
          icon: Icon(
            Icons.home,
            size: 28,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.receipt,
            size: 28,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.person,
            size: 28,
          ),
        )
      ],
      indicatorColor: Colors.transparent,
      unselectedLabelColor: Colors.grey[400],
      labelColor: Colors.blue,
    );
  }

  void handleTabSelection() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
