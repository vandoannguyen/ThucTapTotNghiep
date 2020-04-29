import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonnelViewModel {
  dynamic personnels = [];

  GlobalKey<ScaffoldState> scaffKey;

  PersonnelViewModel() {
    scaffKey = new GlobalKey();
  }
}
