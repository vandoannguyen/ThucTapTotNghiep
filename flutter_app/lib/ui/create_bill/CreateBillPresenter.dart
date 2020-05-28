import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/create_bill/CreateBill.dart';
import 'package:init_app/ui/create_bill/CreateBillView.dart';
import 'package:init_app/ui/search_merchandis/SearchSanPham.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'CreateBilllViewmodel.dart';

class CreateBillPresenter<V extends CreateBillView> extends BasePresenter<V> {
  CreateBillViewmodel _viewmodel;

  static final String PERSONNEL = "PERSONNEL";

  static final String MERCHANDISE = "MERCHANDISE";

  static final String LOADING = "LOADING";

//  static final String PERSONNEL = "PERSONNEL";

  CreateBillPresenter(this._viewmodel) {
    appDataHelper = new AppDataHelper();
    addStreamController(PERSONNEL);
    addStreamController(MERCHANDISE);
    addStreamController(LOADING);
  }

  IAppDataHelper appDataHelper;

  void calculateTotalMerchandises() {
    _viewmodel.tongSo = 0.0;
    _viewmodel.listMerchandis.forEach((element) {
      _viewmodel.tongSo += element["countsp"];
    });
    baseView.updateUI({});
//    tongSo = tong;
  }

  void calculateTotalPrice() {
    _viewmodel.tongTien = 0;
    _viewmodel.listMerchandis.forEach((element) {
      if (_viewmodel.keyCheck == CreateBill.KEY_CHECK_EXPORT_MERCHANDISE)
        _viewmodel.tongTien += element["countsp"] * element["outputPrice"];
      else if (_viewmodel.keyCheck == CreateBill.KEY_CHECK_IMPORT_MERCHANDISE) {
        _viewmodel.tongTien += element["countsp"] * element["inputPrice"];
      }
    });
  }

  void caculateTotalInputPrice() {
    _viewmodel.tongTienNhap = 0;
    _viewmodel.listMerchandis.forEach((element) {
      _viewmodel.tongTienNhap += element["countsp"] * element["inputPrice"];
    });
  }

  void searchMerchandise(context) async {
    var sp = await IntentAnimation.intentNomal(
      context: context,
      screen: SearchSanPhamScreen(),
      option: IntentAnimationOption.RIGHT_TO_LEFT,
      duration: Duration(milliseconds: 500),
    );
    if (sp != null) {
      if (_viewmodel.listMerchandis
              .where((element) => element["barcode"] == sp["barcode"])
              .length ==
          0) {
        sp["countsp"] = 1;
        _viewmodel.listMerchandis.add(sp);
      } else {
        _viewmodel.listMerchandis = _viewmodel.listMerchandis.map((element) {
          if (element["barcode"] == sp["barcode"]) {
            if (element["countsp"] + 1 <= element["count"] &&
                _viewmodel.keyCheck ==
                    CreateBill.KEY_CHECK_EXPORT_MERCHANDISE) {
              element["countsp"]++;
            }
            if (_viewmodel.keyCheck ==
                CreateBill.KEY_CHECK_IMPORT_MERCHANDISE) {
              element["countsp"]++;
            }
          }
          return element;
        }).toList();
      }
      getSink(MERCHANDISE).add(new BlocLoaded(_viewmodel.listMerchandis));
      calculateTotalMerchandises();
      calculateTotalPrice();
      caculateTotalInputPrice();
    }
  }

  void showBarcode() async {
    var barcode = await scan.scan();
    var merchandis = _viewmodel.listSanPham.firstWhere(
        (element) => element["barcode"] == barcode && element["status"] == 1,
        orElse: () => null);
    if (merchandis != null) {
      if (_viewmodel.listMerchandis
              .where((element) => element["barcode"] == merchandis["barcode"])
              .toList()
              .length ==
          0) {
        merchandis["countsp"] = 1;
        _viewmodel.listMerchandis.add(merchandis);
      } else {
        _viewmodel.listMerchandis = _viewmodel.listMerchandis.map((element) {
          if (element["barcode"] == merchandis["barcode"]) {
            if (element["countsp"] + 1 > element["count"]) {
              _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
                content: Text("Nhập quá số lượng!"),
                elevation: 4,
                backgroundColor: Colors.red,
              ));
            } else {
              element["countsp"]++;
            }
          }
          return element;
        }).toList();
      }
    }
    getSink(MERCHANDISE).add(new BlocLoaded(_viewmodel.listMerchandis));
    calculateTotalMerchandises();
    calculateTotalPrice();
    caculateTotalInputPrice();
  }

  void chietKhauSubmitted(String value) {
    _viewmodel.chietKhau = double.parse(value);
  }

  void createBillExport() {
    getSink(LOADING).add(new BlocLoading());
    print(Common.user);
    print(Common.selectedShop["idShop"]);
    print("OUT${DateTime.now().millisecondsSinceEpoch}");
    print(DateTime.now().hour);
    dynamic bill = {
      "listMer": _viewmodel.listMerchandis,
      "name": "OUT${DateTime.now().millisecondsSinceEpoch}",
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
      getSink(LOADING).add(new BlocLoaded({}));
      _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Thêm đơn thành công"),
        elevation: 4,
        backgroundColor: Colors.blue,
      ));
      baseView.backView("ok");
    }).catchError((onError) {
      getSink(LOADING).add(new BlocLoaded({}));
      _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Thêm không thành công!"),
        elevation: 4,
        backgroundColor: Colors.blue,
      ));
    });
  }

  void getMerchandisesByBill(idBill, idShop) async {
    getSink(MERCHANDISE).add(new BlocLoading());
    print('Bearer ' + Common.loginToken);
    appDataHelper.getMerchandisesByBill(idBill, idShop).then((value) {
      print(value);
      _viewmodel.listMerchandis = value;
      getSink(MERCHANDISE).add(new BlocLoaded(value));
      calculateTotalMerchandises();
      caculateTotalInputPrice();
      baseView.updateUI({});
    }).catchError((onError) {
      print(onError);
    });
  }

  void createBillImport() {
    getSink(LOADING).add(new BlocLoading());
    print(Common.user);
    print(Common.selectedShop["idShop"]);
    print("OUT${DateTime.now().millisecondsSinceEpoch}");
    print(DateTime.now().hour);
    dynamic bill = {
      "listMer": _viewmodel.listMerchandis,
      "name": "IN${DateTime.now().millisecondsSinceEpoch}",
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
    appDataHelper.createBill(bill).then((value) {
      getSink(LOADING).add(new BlocLoaded({}));
      _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Thêm đơn thành công"),
        elevation: 4,
        backgroundColor: Colors.blue,
      ));
    }).catchError((onError) {
      getSink(LOADING).add(new BlocLoaded({}));
      _viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Thêm không thành công!"),
        elevation: 4,
        backgroundColor: Colors.blue,
      ));
    });
  }

  void getMerchandisesByShop(idCuaHang) async {
    appDataHelper
        .getMerchandisesByShop(Common.selectedShop["idShop"])
        .then((value) {
      print(value);
      _viewmodel.listSanPham = value;
    }).catchError((err) {
      print(err);
    });
  }

  void getPersonnelByBill(idPersonnel) {
    getSink(PERSONNEL).add(new BlocLoading());
    appDataHelper.getPersonnelByBill(idPersonnel).then((value) {
      print(value);
      getSink(PERSONNEL).add(new BlocLoaded(value));
    }).catchError((err) {
      getSink(PERSONNEL).add(BlocFailed(""));
    });
  }

  void sendEmailMerchandise() {}
}
