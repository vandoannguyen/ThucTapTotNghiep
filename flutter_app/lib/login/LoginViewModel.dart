import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel {
  dynamic _user;
  AnimationController _controller;

  TextEditingController userNameController, passwordController;

  AnimationController get controller => _controller;

  set controller(AnimationController value) {
    _controller = value;
  }

  LoginViewModel() {
    _user = {};
    userNameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  dynamic get user => _user;

  set user(dynamic value) {
    _user = value;
  }
}
