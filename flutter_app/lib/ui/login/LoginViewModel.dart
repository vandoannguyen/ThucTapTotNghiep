import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  dynamic _user;
  BuildContext _context;

  TextEditingController userNameController, passwordController;

  var isHide = true;

  var isCheck = false;

  var isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey;

  BuildContext get context => _context;
  FocusNode fcPass;
  set context(BuildContext value) {
    _context = value;
  }

  LoginViewModel() {
    _user = {};
    userNameController = new TextEditingController();
    passwordController = new TextEditingController();
    fcPass = new FocusNode();
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  dynamic get user => _user;

  set user(dynamic value) {
    _user = value;
  }
}
