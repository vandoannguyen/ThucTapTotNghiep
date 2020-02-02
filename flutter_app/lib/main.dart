import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/CallNativeUtils.dart';

import 'config.dart';
import 'login/Login.dart';

void main() async {
  Common.config = config;
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CallNativeUtils.setChannel("com.example.init_app");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColorDark: Colors.grey[700],
          appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 4,
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 20)))),
      home: Login(),
    );
  }
}
