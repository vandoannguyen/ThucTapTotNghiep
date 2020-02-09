import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/home/HomeScreen.dart';
import 'package:init_app/login/LoginViewModel.dart';
import 'package:init_app/register/Register.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class LoginPresenter implements BasePresenter {
  BaseView baseView;
  LoginViewModel _viewModel;

  LoginPresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    this.baseView = baseView;
  }

  void postLogin(user) {
    print(user);
    http.post("${Common.rootUrlApi}login", body: user).then((value) {
      print(value.body);
      if (value.statusCode == 200 && value.body != {}) {
        var response = jsonDecode(value.body);
        Common.user = response["user"];
        Common.loginToken = response["token"];
        Common.shops = response["shop"];
        Common.selectedShop = Common.shops[0];
        print(Common.user);
        print(Common.loginToken);
        print(Common.shops);
        if (value.body != "") print(Common.loginToken);
        IntentAnimation.intentPushReplacement(
            context: _viewModel.context,
            screen: HomeScreen(),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 800));
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
