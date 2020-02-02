import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/register/RegisterViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/CallNativeUtils.dart';

class RegisterPresenter implements BasePresenter {
  RegisterViewModel _viewModel;
  BaseView _baseView;
  RegisterPresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
    _baseView = baseView;
  }

  void dangKy() {
    var value = {
      "username": _viewModel.usernameController.text,
      "password": _viewModel.passwordController.text,
      "email": _viewModel.emailController.text,
      "name": _viewModel.fullNameController.text,
      "image": _viewModel.avatarImage != null ? _viewModel.avatarImage : ""
    };
    http.post("${Common.rootUrl}register", body: value).then((value) {
      print(value.body);
    }).catchError((err) {
      print(err);
    });
  }

  void setImage(callBack) {
    CallNativeUtils.invokeMethod(method: "getImage").then((value) {
      Uint8List image = base64.decode(value);
      callBack(image);
    });
  }
}
