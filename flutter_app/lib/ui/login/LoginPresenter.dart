import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/main.dart';
import 'package:init_app/ui/home/HomeScreen.dart';
import 'package:init_app/ui/login/LoginView.dart';
import 'package:init_app/ui/register/Register.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginViewModel.dart';

class LoginPresenter<V extends LoginView> extends BasePresenter<V> {
  LoginViewModel _viewModel;
  IAppDataHelper appDataHelper;

  LoginPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  @override
  void intiView(BaseView baseView) {
    this.baseView = baseView;
  }

  void postLogin(context, user) {
    if (_viewModel.isCheck) {
      appDataHelper.saveUserName(_viewModel.userNameController.text);
      appDataHelper.savePass(_viewModel.passwordController.text);
    }
    _viewModel.isLoading = true;
    baseView.updateUI({});
    appDataHelper.postLogin(user).then((value) async {
      if (value != null && value["status"] != 400) {
        Common.user = value["user"];
        Common.loginToken = value["token"];
        Common.shops = value["shop"];
        Common.selectedShop = Common.shops.length > 0 ? Common.shops[0] : {};
        if (Common.shops.length > 0) {
          IntentAnimation.intentPushReplacement(
              context: _viewModel.context,
              screen: HomeScreen(),
              option: IntentAnimationOption.RIGHT_TO_LEFT,
              duration: Duration(milliseconds: 800));
        } else {
          _viewModel.isLoading = false;
          baseView.updateUI({});
          baseView.showSnackBar(key: "shop", message: "");
        }
      } else {
        _viewModel.isLoading = false;
        baseView.updateUI({});
        if (value["status"] == 400) {
          print("post login");
          baseView.showSnackBar(key: "message", message: value["message"]);
        }
      }
    }).catchError((onError) {
      print(onError);
      _viewModel.isLoading = false;
      baseView.updateUI({});
      print("1234567890" + onError.toString());
//      baseView.showSnackBar(key: "message", message: jsonDecode(value.body)["message"]);
    });
  }

  void register(BuildContext context) {
    IntentAnimation.intentNomal(
            context: context,
            screen: Register(Register.REGISTER),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 700))
        .then((value) {
      if (value != null) {
        _viewModel.userNameController.text = value["username"];
        _viewModel.passwordController.text = value["password"];
        _viewModel.scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: Text("Đăng ký thành công"),
            elevation: 4,
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void usernameSummit() {
    _viewModel.fcPass.requestFocus();
  }

  void dispose() {
    if (_viewModel.fcPass != null) _viewModel.fcPass.dispose();
  }

  void rememberMe(bool value) {
    appDataHelper.rememberMe(value);
  }

  void getRememberMe() async {
    prefer = await SharedPreferences.getInstance();
    bool isRemember = await appDataHelper.getRememberMe();
    if (isRemember) {
      _viewModel.isCheck = isRemember;
    } else {
      _viewModel.isCheck = false;
    }
    if (isRemember) {
      String username = await appDataHelper.getUser();
      String pas = await appDataHelper.getPass();
      _viewModel.isCheck = isRemember;
      if (username != null) {
        _viewModel.userNameController.text = username;
      }
      if (pas != null) {
        _viewModel.passwordController.text = pas;
      }
      baseView.updateUI({});
    }
  }
}
