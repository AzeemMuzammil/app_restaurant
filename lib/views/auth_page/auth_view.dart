import 'package:app_restaurant/views/auth_page/auth_page.dart';
import 'package:app_restaurant/views/auth_page/register_view.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isCustomerSelected;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    isCustomerSelected = true;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final customSnackBar = CustomSnackBar(scaffoldKey: _scaffoldKey);
    final scaffold = Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login to Mcmillan"),
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
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/logo.jpg')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCustomerSelected = true;
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Customer",
                            style: TextStyle(
                              fontSize: 18,
                              color: isCustomerSelected
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        width: width / 2 - 20,
                        color: isCustomerSelected ? Colors.blue : Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCustomerSelected = false;
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            "Manager",
                            style: TextStyle(
                              fontSize: 18,
                              color: isCustomerSelected
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                        width: width / 2 - 20,
                        color: isCustomerSelected ? Colors.white : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  authBloc.add(
                    LoginPressedEvent(
                      !isCustomerSelected,
                      _emailController.text,
                      _passwordController.text,
                    ),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: authBloc,
                      child: RegisterView(),
                    ),
                  ),
                );
              },
              child: Text(
                'New User? Create Account',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error != "") {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
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
