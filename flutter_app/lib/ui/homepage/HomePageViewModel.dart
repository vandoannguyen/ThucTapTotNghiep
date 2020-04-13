import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageViewModel {
  var currencyFormat = NumberFormat("#,###,###,##0", "en_US");
  dynamic bestSellers = [];

  dynamic marchandiseWillEmpty = [];

  DateTime firstDay;

  DateTime endDay;

  dynamic bills = [];

  GlobalKey<ScaffoldState> scaffKeyHomePage;

  HomePageViewModel() {
    scaffKeyHomePage = new GlobalKey();
  }
}
