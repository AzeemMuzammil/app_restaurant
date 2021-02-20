import 'package:app_restaurant/views/root_page/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Mcmillan"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/images/logo.jpg')),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "${rootBloc.state.user.firstName} ${rootBloc.state.user.lastName}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 36,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              child: FlatButton(
                onPressed: () {
                  rootBloc.add(
                    LogoutEvent(),
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
