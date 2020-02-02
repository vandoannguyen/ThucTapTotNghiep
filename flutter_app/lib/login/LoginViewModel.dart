import 'package:flutter/cupertino.dart';

class LoginViewModel {
  dynamic _user;
  BuildContext _context;

  TextEditingController userNameController, passwordController;

  BuildContext get context => _context;

  set context(BuildContext value) {
    _context = value;
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
