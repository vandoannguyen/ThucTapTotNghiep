import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/login/Login.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class LoadApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    http
        .get(
            "https://raw.githubusercontent.com/vandoannguyen/ThucTapTotNghiep/master/api.json")
        .then((value) {
      dynamic data = jsonDecode(value.body);
      Common.rootUrlApi = data["rootUrlApi"];
      Common.rootUrl = data["rootUrl"];
      print(Common.rootUrlApi + "   " + Common.rootUrl);
      IntentAnimation.intentPushReplacement(
          context: context,
          screen: Login(),
          option: IntentAnimationOption.RIGHT_TO_LEFT,
          duration: Duration(seconds: 1));
    }).catchError((err) {
      print(err);
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "assets/icons/loading.gif",
              width: 30,
              height: 30,
            ),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
