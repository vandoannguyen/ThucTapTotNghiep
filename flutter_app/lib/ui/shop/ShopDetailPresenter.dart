import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/utils/BasePresenter.dart';

import 'ShopDetailView.dart';
import 'ShopDetailViewModel.dart';

class ShopDetailPresenter<V extends ShopDetailView> extends BasePresenter<V> {
  ShopDetailViewModel _viewModel;
  IAppDataHelper appDataHelper;

  ShopDetailPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  void getImage(calback) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    _viewModel.avatarImage = FileImage(image);
    List<int> imageBytes = image.readAsBytesSync();
    print(imageBytes);
    _viewModel.base64Image = base64Encode(imageBytes);
    calback();
  }

  void addShop() {
    dynamic data = {
      "name": _viewModel.shopNameCtrl.text,
      "address": _viewModel.addressCtrl.text,
      "idShopkepper": Common.user["idUser"],
      "image": "",
      "dateCreate": DateTime.now().millisecondsSinceEpoch,
      "phoneNumber": _viewModel.phoneNumberCtrl.text,
      "description": _viewModel.descriptionCtrl.text,
      "warningCount": int.parse(_viewModel.warningCountEditCtrl.text),
    };

    print(data);
    if (_viewModel.formKey.currentState.validate()) {
      appDataHelper.createShop(data).then((value) {
        print(value);
      }).catchError((err) {
        print(err);
      });
    }
  }

  String validator(String value) {
    if (value == null || value == "") return "Nhập thiếu";
  }
}
