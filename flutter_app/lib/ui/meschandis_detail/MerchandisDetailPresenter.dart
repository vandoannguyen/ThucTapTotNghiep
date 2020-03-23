import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/meschandis_detail/MechandisDetail.dart';
import 'package:init_app/ui/meschandis_detail/MerchandiseView.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'MerchandisDetailViewModel.dart';

class MerchandiseDetailPresenter<V extends MerchandiseDetailView>
    extends BasePresenter<V> {
  MerchandiseDetailViewModel _viewModel;
  IAppDataHelper appDataHelper;

  MerchandiseDetailPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  void showBarcode() async {
    var barcode = await scan.scan();
    print("1234567890");
    print(barcode);
    _viewModel.barcodeControl.text = barcode;
    baseView.updateUI({});
  }

  void getAvatar() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    _viewModel.avatarImage = FileImage(image);
    List<int> imageBytes = image.readAsBytesSync();
    print(imageBytes);
    _viewModel.base64Image = base64Encode(imageBytes);
    baseView.updateUI({});
  }

  void getCategory() async {
    appDataHelper.getCategories(Common.selectedShop["idShop"]).then((value) {
      _viewModel.categories = value;
      print(value);
      baseView.updateUI({});
    }).catchError((onError) {
      print(onError);
    });
  }

  void createMerchandis(context) {
    var data = {
      "barcode": _viewModel.barcodeControl.text,
      "image": _viewModel.base64Image,
      "idShop": Common.selectedShop["idShop"],
      "nameMerchandise": _viewModel.tenSpControl.text,
      "idCategory": _viewModel.selectedCategory["idCategory"],
      "inputPrice": double.parse(_viewModel.inputPriceController.text),
      "outputPrice": double.parse(_viewModel.outputPriceController.text),
      "count": int.parse(_viewModel.totalMerchandiseController.text),
      "unit": '',
    };
    appDataHelper.createMerchandise(data).then((onValue) {
      baseView.showSnackBar(
          keyInput: MerchandiseDetail.API_SUCCESS, mess: "Thêm thành công");
      _showDialogSuccess(context);
    }).catchError((err) {
      baseView.showSnackBar(keyInput: MerchandiseDetail.API_FAILD, mess: err);
    });
  }

  void updateMerchandise() {
    if (_viewModel.base64Image == "") {
      _viewModel.base64Image = _viewModel.value["image"];
    }
    var data = {
      "barcode": _viewModel.barcodeControl.text,
      "image": _viewModel.base64Image,
      "idShop": Common.selectedShop["idShop"],
      "nameMerchandise": _viewModel.tenSpControl.text,
      "idCategory": _viewModel.selectedCategory["idCategory"],
      "inputPrice": double.parse(_viewModel.inputPriceController.text),
      "outputPrice": double.parse(_viewModel.outputPriceController.text),
      "count": int.parse(_viewModel.totalMerchandiseController.text),
      "unit": '',
    };
    appDataHelper.updateMerchandise(data).then((value) {}).catchError((err) {});
  }

  void deleteMerchandise(value) {}

  void _showDialogSuccess(context) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Thêm thành công.\nBạn có muốn tiếp tục?"),
          actions: <Widget>[
            FlatButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text('Có'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                baseView.continueAdd(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
