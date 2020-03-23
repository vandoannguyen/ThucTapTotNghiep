import 'package:flutter/cupertino.dart';

class CreateBillViewmodel {
  dynamic listMerchandis = [];
  var tongSo = 0.0;
  var tongTien = 0.0;
  var chietKhau = 0.0;
  var editEnable = true;
  FocusNode focusNodeChietKhau;

  TextEditingController chietKhauController;

  TextEditingController ghiChuController;

  var listSanPham = [];
  CreateBillViewmodel() {
    editEnable = true;
    focusNodeChietKhau = new FocusNode();
    chietKhauController = new TextEditingController(text: '${0}');
    ghiChuController = new TextEditingController();
  }
}
