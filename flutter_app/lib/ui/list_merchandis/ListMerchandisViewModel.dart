import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListMerchandisViewModel {
  dynamic selectedCategory = {};
  dynamic selectedListMerchandise = [];
  dynamic categories = [];

  dynamic merchandises = [];
  GlobalKey<ScaffoldState> scaffState;

  ListMerchandisViewModel() {
    scaffState = new GlobalKey();
  }
}
