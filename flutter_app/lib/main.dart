import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/login/Login.dart';
import 'package:init_app/utils/CallNativeUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

SharedPreferences prefer;

void main() async {
  Common.config = config;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CallNativeUtils.setChannel("com.example.init_app");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Shop',
      theme: ThemeData(
          fontFamily: "Roboto",
          primarySwatch: Colors.blue,
          primaryColorDark: Colors.grey[700],
          appBarTheme: AppBarTheme(
              color: Colors.blue[400],
              elevation: 4,
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20)))),
      home: Login(),
    );
  }

  String getInterstitialAdUnitId() {
    return 'ca-app-pub-3940256099942544/1033173712';
  }
}
