import 'package:flutter/cupertino.dart';

class RegisterViewModel {
  TextEditingController usernameController,
      fullNameController,
      emailController,
      passwordController,
      confirmPassController;
  var avatarImage;

  var passwordVisible = false;

  String base64Image = "";
  RegisterViewModel() {
    avatarImage = null;
    usernameController = new TextEditingController();
    fullNameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPassController = new TextEditingController();
  }
}
