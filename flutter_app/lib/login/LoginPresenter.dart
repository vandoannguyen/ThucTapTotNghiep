import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/register/Register.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class LoginPresenter implements BasePresenter {
  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
  }

  void postLogin(user) {
    print(user);
    http.post("${Common.rootUrl}login", body: user).then((value) {
      if (value.statusCode == 200) {
        Common.loginToken = value.body;
        if (value.body != "") print(value.body);
      }
    }).catchError((error) {
      print(error);
    });
  }

  void register(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: Register(),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 700));
  }
}
