import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListBillViewModel {
  bool isExportBill = true;

  DateTime firstDay;

  DateTime endDay;

  dynamic bills = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  ListBillViewModel() {
    scaffoldKey = new GlobalKey();
  }
}
