import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/meschandis_detail/MechandisDetail.dart';
import 'package:init_app/ui/meschandis_detail/MerchandiseView.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'MerchandisDetailViewModel.dart';

class MerchandiseDetailPresenter<V extends MerchandiseDetailView>
    extends BasePresenter<V> {
  MerchandiseDetailViewModel _viewModel;
  IAppDataHelper appDataHelper;

  static final String SET_AVATAR = "SET_AVATAR";

  MerchandiseDetailPresenter(this._viewModel) : super() {
    appDataHelper = new AppDataHelper();
    addStreamController(SET_AVATAR);
  }

  void showBarcode() async {
    var barcode = await scan.scan();
    print("1234567890");
    print(barcode);
    _viewModel.barcodeControl.text = barcode;
    baseView.updateUI({});
  }

  void getAvatar() async {
    ImagePicker.pickImage(
            source: ImageSource.camera, maxHeight: 360, maxWidth: 480)
        .then((image) {
      _viewModel.avatarImage = FileImage(image);
      List<int> imageBytes = image.readAsBytesSync();
      _viewModel.base64Image = base64Encode(imageBytes);
      getSink(SET_AVATAR).add(new BlocSetFile(_viewModel.avatarImage));
//      baseView.updateUI({});
    });
  }

  void getCategory() async {
    appDataHelper.getCategories(Common.selectedShop["idShop"]).then((value) {
      _viewModel.categories = value;
      _viewModel.selectedCategory = value[value.length - 1];
      baseView.updateUI({});
    }).catchError((onError) {
      print(onError);
    });
  }

  void createMerchandis(context) {
    if (_viewModel.formKey.currentState.validate()) {
      var data = {
        "barcode": _viewModel.barcodeControl.text,
        "image": _viewModel.base64Image,
        "idShop": Common.selectedShop["idShop"],
        "nameMerchandise": _viewModel.tenSpControl.text,
        "idCategory": _viewModel.selectedCategory["idCategory"],
        "inputPrice": double.parse(_viewModel.inputPriceController.text),
        "outputPrice": double.parse(_viewModel.outputPriceController.text),
        "count": int.parse(_viewModel.totalMerchandiseController.text),
        "emailProvider": _viewModel.emailProvider.text,
      };
      appDataHelper.createMerchandise(data).then((onValue) {
        baseView.showSnackBar(
            keyInput: MerchandiseDetail.API_SUCCESS, mess: "Thêm thành công");
        _showDialogSuccess(context);
      }).catchError((err) {
        baseView.showSnackBar(keyInput: MerchandiseDetail.API_FAILD, mess: err);
      });
    }
  }

  void updateMerchandise() {
    if (_viewModel.formKey.currentState.validate()) {
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
        "emailProvider": _viewModel.emailProvider.text,
      };
      print(data);
      appDataHelper.updateMerchandise(data).then((value) {
        _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Text("Sửa thông tin thành công"),
          duration: Duration(seconds: 2),
          elevation: 4,
          backgroundColor: Colors.blue,
        ));
        _viewModel.updateSuccess = true;
      }).catchError((err) {
        _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: Text("Sửa thông tin không thành công!"),
          duration: Duration(seconds: 2),
          elevation: 4,
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  void deleteMerchandise(context, value) {
    appDataHelper
        .deleteMerchandise(value["barcode"], value["idShop"])
        .then((value) {
      Navigator.pop(context, "delete");
    }).catchError((onError) {});
  }

  void _showDialogSuccess(context) {
    showDialog<String>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text("Thêm thành công.\nBạn có muốn tiếp tục?"),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  IntentAnimation.intentBack(context: dialogContext);
                },
                child: Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    width: 100,
                    child: Text(
                      "Có",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () {
                IntentAnimation.intentBack(context: context, result: "back");
              },
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    "Không",
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      print("back okok");
      print(value);
      if (value == "back") {
        IntentAnimation.intentBack(context: context, result: "ok");
      }
    });
  }
}

class BlocSetFile extends BlocEvent {
  FileImage value;

  BlocSetFile(this.value);
}
