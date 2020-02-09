import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'MerchandisDetailViewModel.dart';

class MerchandisDetailPresenter implements BasePresenter {
  BaseView baseView;
  MerchandisDetailViewModel _viewModel;

  MerchandisDetailPresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
    this.baseView = baseView;
  }

  void showBarcode() async {
    var barcode = await scan.scan();
    print("1234567890");
    print(barcode);
    _viewModel.barcodeControl.text = barcode;
    baseView.updateUI({});
  }

  void getAvatar(calback) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    _viewModel.avatarImage = FileImage(image);
    List<int> imageBytes = image.readAsBytesSync();
    print(imageBytes);
    _viewModel.base64Image = base64Encode(imageBytes);
    calback();
  }

  void getCategory(callBack) async {
    http.get(Common.rootUrlApi + "category/listCategory?idShop=${1}", headers: {
      HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken
    }).then((value) {
      _viewModel.categiroes = jsonDecode(value.body);
      callBack();
    });
  }

  void createMerchandis() {
    var data = {
      "barcode": _viewModel.barcodeControl.text,
      "image": _viewModel.base64Image,
      "idShop": Common.selectedShop["idShop"],
      "nameMerchandise": _viewModel.tenSpControl.text,
      "idCategory": _viewModel.selectedCategoty["idCategory"],
      "inputPrice": double.parse(_viewModel.giaNhapController.text),
      "outputPrice": double.parse(_viewModel.giaBanController.text),
      "count": int.parse(_viewModel.soLuongTrongKhoController.text),
      "unit": '',
    };
//    params["barcode"],
//    params["image"],
//    params["idShop"],
//    params["nameMerchandise"],
//    params["idCategory"],
//    params["idCategory"],
//    params["inputPrice"],
//    params["outputPrice"],
//    params["count"],
//    params["unit"],
    http.post(Common.rootUrlApi + "merchandise/createMerchandise",
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        });
  }

  void updateMerchandis() {}

  void deteteSp(value) {}
}
