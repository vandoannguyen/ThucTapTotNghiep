import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Common.heightOfScreen,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text("HomePage"),
          ),
        ),
      ),
    );
  }
}
