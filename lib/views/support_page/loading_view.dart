import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    height: 24,
                  ),
                  CupertinoActivityIndicator(
                    radius: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
