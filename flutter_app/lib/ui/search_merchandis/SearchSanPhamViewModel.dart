import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchSanPhamViewModel {
  dynamic _listSanPham = [];

  dynamic get listSanPham => _listSanPham;

  set listSanPham(dynamic value) {
    _listSanPham = value;
  }
  GlobalKey<ScaffoldState> scaffoldSearSanPham;

  SearchSanPhamViewModel(){
    scaffoldSearSanPham = new GlobalKey();
  }

}
