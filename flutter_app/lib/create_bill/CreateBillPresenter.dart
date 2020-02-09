import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/search_merchandis/SearchSanPham.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'CreateBilllViewmodel.dart';

class CreateBillPresenter implements BasePresenter {
  CreateBillViewmodel _viewmodel;
  BaseView baseView;

  CreateBillPresenter(this._viewmodel);
  void tinhTongSo() {
    _viewmodel.tongSo = 0.0;
    _viewmodel.listMerchandis.forEach((element) {
      _viewmodel.tongSo += element["countsp"];
    });

//    tongSo = tong;
  }

  void tinhTongTien() {
    _viewmodel.tongTien = 0;
    _viewmodel.listMerchandis.forEach((element) {
      _viewmodel.tongTien += element["countsp"] * element["outputPrice"];
    });
  }

  void searchSanPham(context) async {
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
      tinhTongSo();
      tinhTongTien();
      print(_viewmodel.listMerchandis);
    }
  }

  void showBarcode() async {
    var barcode = await scan.scan();
    print("barcode ${barcode}");
  }

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
    this.baseView = baseView;
  }

  void chietKhauSubmitted(String value) {
    _viewmodel.chietKhau = double.parse(value);
  }

  void createBill() {
    print(Common.user);
    print(Common.selectedShop["idShop"]);
    print("OUT${DateTime.now().millisecondsSinceEpoch}");
    dynamic bill = {
      "listMer": _viewmodel.listMerchandis,
      "name": "OUT${DateTime.now().millisecondsSinceEpoch}",
      "status": 0,
      "idSeller": Common.user["idUser"],
      "dateCreate": DateTime.now().millisecondsSinceEpoch,
      "discount": _viewmodel.chietKhau,
      "idShop": 1,
      "totalPrice": _viewmodel.tongTien,
      "description": _viewmodel.ghiChuController.text
    };
    print(bill);
    http.post(Common.rootUrlApi + "bill/createbill",
        body: jsonEncode(bill),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Common.loginToken}",
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.contentTypeHeader: 'application/json'
        });
  }

  void getListSanPham(idCuaHang) async {
    print('Bearer ' + Common.loginToken);
    var resopnse = await http.get(
      "${Common.rootUrlApi}merchandise/listMerchandise?idCuaHang=1",
      headers: {
        "Authorization": 'Bearer ' + Common.loginToken,
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      },
    );
    _viewmodel.listSanPham = jsonDecode(resopnse.body);
//    _viewmodel.updateUI(dynamic);
    print("1234567890");
    print(_viewmodel.listSanPham);
  }
}
