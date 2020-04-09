import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/create_bill/CreateBillView.dart';
import 'package:init_app/ui/search_merchandis/SearchSanPham.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'CreateBilllViewmodel.dart';

class CreateBillPresenter<V extends CreateBillView> extends BasePresenter<V> {
  CreateBillViewmodel _viewmodel;

  CreateBillPresenter(this._viewmodel) {
    appDataHelper = new AppDataHelper();
  }

  IAppDataHelper appDataHelper;

  void calculateTotalMerchandises() {
    _viewmodel.tongSo = 0.0;
    _viewmodel.listMerchandis.forEach((element) {
      _viewmodel.tongSo += element["countsp"];
    });

//    tongSo = tong;
  }

  void calculateTotalPrice() {
    _viewmodel.tongTien = 0;
    _viewmodel.listMerchandis.forEach((element) {
      _viewmodel.tongTien += element["countsp"] * element["outputPrice"];
    });
  }

  void searchMerchandise(context) async {
    var sp = await IntentAnimation.intentNomal(
      context: context,
      screen: SearchSanPhamScreen(),
      option: IntentAnimationOption.RIGHT_TO_LEFT,
      duration: Duration(milliseconds: 500),
    );
    if (sp != null &&
        _viewmodel.listMerchandis
                .where((element) => element["barcode"] == sp["barcode"])
                .length ==
            0) {
      sp["countsp"] = 1;
      _viewmodel.listMerchandis.add(sp);
      calculateTotalMerchandises();
      calculateTotalPrice();
      print(_viewmodel.listMerchandis);
    }
  }

  void showBarcode() async {
    var barcode = await scan.scan();
    var merchandis = _viewmodel.listSanPham.firstWhere(
        (element) => element["barcode"] == barcode,
        orElse: () => null);
    print(merchandis);
    if (merchandis != null) {
      merchandis["countsp"] = 1;
      _viewmodel.listMerchandis.add(merchandis);
    }
    print(_viewmodel.listMerchandis);
    baseView.updateUI({});
  }

  void chietKhauSubmitted(String value) {
    _viewmodel.chietKhau = double.parse(value);
  }

  void createBillExport() {
    print(Common.user);
    print(Common.selectedShop["idShop"]);
    print("OUT${DateTime.now().millisecondsSinceEpoch}");
    print(DateTime.now().hour);
    dynamic bill = {
      "listMer": _viewmodel.listMerchandis,
      "name": "OUT${DateTime.now().millisecondsSinceEpoch}",
      "status": 0,
      "idSeller": Common.user["idUser"],
      "dateCreate": DateTime.now().toIso8601String().replaceFirst("T", " "),
      "discount": double.parse(_viewmodel.chietKhauController.text == ''
          ? "0"
          : _viewmodel.chietKhauController.text),
      "idShop": Common.selectedShop["idShop"],
      "totalPrice": _viewmodel.tongTien,
      "description": _viewmodel.ghiChuController.text
    };
    print(bill);
    appDataHelper
        .createBill(bill)
        .then((value) {
          _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: Text("Thêm đơn thành công"),
            elevation: 4,
            backgroundColor: Colors.blue,
          ));
          baseView.backView("ok");
        })
        .catchError((onError) {})
        .catchError((onError) {
          _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: Text("Thêm không thành công!"),
            elevation: 4,
            backgroundColor: Colors.blue,
          ));
        });
  }

  void getMerchandisesByBill(idBill, idShop) async {
    print('Bearer ' + Common.loginToken);
    appDataHelper.getMerchandisesByBill(idBill, idShop).then((value) {
      _viewmodel.listMerchandis = value;
      calculateTotalMerchandises();
      baseView.updateUI({});
    }).catchError((onError) {
      print(onError);
    });
  }

  void createBillImport() {
    print(Common.user);
    print(Common.selectedShop["idShop"]);
    print("OUT${DateTime.now().millisecondsSinceEpoch}");
    print(DateTime.now().hour);
    dynamic bill = {
      "listMer": _viewmodel.listMerchandis,
      "name": "IN${DateTime.now().millisecondsSinceEpoch}",
      "status": 1,
      "idSeller": Common.user["idUser"],
      "dateCreate": DateTime.now().toIso8601String().replaceFirst("T", " "),
      "discount": double.parse(_viewmodel.chietKhauController.text == ''
          ? "0"
          : _viewmodel.chietKhauController.text),
      "idShop": Common.selectedShop["idShop"],
      "totalPrice": _viewmodel.tongTien,
      "description": _viewmodel.ghiChuController.text
    };
    print(bill);
    appDataHelper.createBill(bill).then((value) {
      _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Thêm đơn thành công"),
        elevation: 4,
        backgroundColor: Colors.blue,
      ));
    }).catchError((onError) {
      _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Thêm không thành công!"),
        elevation: 4,
        backgroundColor: Colors.blue,
      ));
    });
  }

  void getMerchandisesByShop(idCuaHang) async {
    print('Bearer ' + Common.loginToken);
    appDataHelper
        .getMerchandisesByShop(Common.selectedShop["idShop"])
        .then((value) {
      _viewmodel.listSanPham = value;
      print(_viewmodel.listSanPham);
    }).catchError((err) {
      print(err);
    });
  }
}
