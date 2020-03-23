import 'dart:async';
import 'dart:wasm';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharepreferHelper {
  Future getRememberMe();

  Future rememberMe(value);

  Future<String> getUser();

  Future<String> getPass();

  Future<Void> savePass(str);

  Future<Void> saveUserName(str);
}

class SharepreferHelper implements ISharepreferHelper {
  static String SHARE_PREFER_REMEMBER_ME = "remember";
  static String USER_NAME = "username";
  static String PASSWORD = "password";

  @override
  Future<bool> getRememberMe() async {
    // TODO: implement getRememberMe
    Completer completer = new Completer();
    SharedPreferences prefer = await SharedPreferences.getInstance();
    bool isRemember = prefer.getBool(SHARE_PREFER_REMEMBER_ME);
    completer.complete(isRemember);
    return completer.future;
  }

  @override
  Future rememberMe(value) async {
    // TODO: implement rememberMe
    Completer completer = new Completer();
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setBool(SHARE_PREFER_REMEMBER_ME, value);
    return completer.future;
  }

  @override
  Future<String> getPass() async {
    // TODO: implement getPass
    Completer completer = new Completer();
    SharedPreferences prefer = await SharedPreferences.getInstance();
    completer.complete(prefer.getString(PASSWORD));
    return completer.future;
  }

  @override
  Future<String> getUser() async {
    // TODO: implement getUser
    Completer completer = new Completer();
    SharedPreferences prefer = await SharedPreferences.getInstance();
    completer.complete(prefer.getString(USER_NAME));
    return completer.future;
  }

  @override
  Future<Void> savePass(str) async {
    // TODO: implement savePass
    Completer completer = new Completer();
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setString(PASSWORD, str);
    completer.complete(null);
    return completer.future;
  }

  @override
  Future<Void> saveUserName(str) async {
    // TODO: implement saveUserName
    Completer completer = new Completer();
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setString(USER_NAME, str);
    completer.complete(null);
    return completer.future;
  }
}
