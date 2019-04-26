import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/ui/list_bill/ListBillPressenter.dart';

class ListBillViewModel {
  bool isExportBill = true;

  DateTime firstDay;

  DateTime endDay;

  dynamic bills = [];

  GlobalKey<ScaffoldState> scaffoldKey;

  var choseOption;

  var order;

  dynamic listFilled = [];

  ListBillViewModel() {
    scaffoldKey = new GlobalKey();
    choseOption = ListBillPresenter.DATE;
    order = "up";
  }
}
