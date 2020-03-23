import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryViewModel {
  TextEditingController tenLoaiMatHangContrller;
  dynamic danhSachLoaiMatHang = [];

  GlobalKey<ScaffoldState> scaffoldKey;
  CategoryViewModel() {
    tenLoaiMatHangContrller = new TextEditingController();
    scaffoldKey = new GlobalKey();
  }
}
