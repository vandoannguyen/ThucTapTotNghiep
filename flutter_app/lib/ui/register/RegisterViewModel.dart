import 'package:flutter/cupertino.dart';

class RegisterViewModel {
  FocusNode fcName, fcEmail, fcUsername, fcPassword, fcConfirmPass;
  TextEditingController usernameController,
      fullNameController,
      emailController,
      passwordController,
      confirmPassController;
  var avatarImage;

  var passwordVisible = false;

  String base64Image = "";

  BuildContext context;
  RegisterViewModel() {
    fcName = new FocusNode();
    fcEmail = new FocusNode();
    fcUsername = new FocusNode();
    fcPassword = new FocusNode();
    fcConfirmPass = new FocusNode();
    avatarImage = null;
    usernameController = new TextEditingController();
    fullNameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmPassController = new TextEditingController();
  }
}
