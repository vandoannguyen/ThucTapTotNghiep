import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreViewModel {
  TextEditingController curentPass, newPass, confirmPass;
  var isHidePass = true;

  GlobalKey<FormState> formKey;

  GlobalKey<ScaffoldState> scaffolKey;

  var isLoading = false;

  FocusNode fcNewPass;

  FocusNode fcConfirm;

  MoreViewModel() {
    fcConfirm = new FocusNode();
    fcNewPass = new FocusNode();
    scaffolKey = new GlobalKey();
    curentPass = new TextEditingController();
    newPass = new TextEditingController();
    confirmPass = new TextEditingController();
    formKey = new GlobalKey();
  }
}
