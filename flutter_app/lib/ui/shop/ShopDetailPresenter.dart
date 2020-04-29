import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'ShopDetailView.dart';
import 'ShopDetailViewModel.dart';

class ShopDetailPresenter<V extends ShopDetailView> extends BasePresenter<V> {
  ShopDetailViewModel _viewModel;
  IAppDataHelper appDataHelper;
  static const String LOADING = "LOADING";
  ShopDetailPresenter(this._viewModel) : super() {
    addStreamController(LOADING);
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
    getSink(LOADING).add(new BlocLoading());
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
        _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Text(value),
          elevation: 4,
          backgroundColor: Colors.blue,
        ));
        Common.shops.add(data);
        getSink(LOADING).add(new BlocLoaded(""));
      }).catchError((err) {
        getSink(LOADING).add(new BlocLoaded(""));
        _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Text(err),
          elevation: 4,
          backgroundColor: Colors.blue,
        ));
      });
    }
  }

  String validator(String value) {
    if (value == null || value == "") return "Nhập thiếu";
  }

  updateShop() {
    getSink(LOADING).add(new BlocLoading());
    dynamic data = {
      "name": _viewModel.shopNameCtrl.text,
      "address": _viewModel.addressCtrl.text,
      "idShopkepper": Common.user["idUser"],
      "image": "",
      "phoneNumber": _viewModel.phoneNumberCtrl.text,
      "description": _viewModel.descriptionCtrl.text,
      "warningCount": int.parse(_viewModel.warningCountEditCtrl.text),
      "idShop": Common.selectedShop["idShop"],
    };

    print(data);
    if (_viewModel.formKey.currentState.validate()) {
      appDataHelper.updateShop(data).then((value) {
        print(value);
        data["dateCreate"] = Common.selectedShop["dateCreate"];
        Common.selectedShop = data;
        getSink(LOADING).add(new BlocLoaded(""));
        _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Text(value),
          elevation: 4,
          backgroundColor: Colors.blue,
        ));
      }).catchError((err) {
        getSink(LOADING).add(new BlocLoaded(""));
        _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Text("Cập nhật thông tin không thành công!"),
          elevation: 4,
          backgroundColor: Colors.red,
        ));
        print(err);
      });
    }
  }
}
