import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/billpage/BillPageViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'ListBill.dart';

class BillPagePresenter implements BasePresenter {
  BillPageViewModel _viewModel;
  BaseView baseView;
  IAppDataHelper appDataHelper;

  BillPagePresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  void listBill(BuildContext context) {
    appDataHelper.getListBill(Common.selectedShop["idShop"]).then((onValue) {
      print(onValue);
      IntentAnimation.intentNomal(
          context: context,
          screen: ListBill(onValue),
          option: IntentAnimationOption.RIGHT_TO_LEFT,
          duration: Duration(milliseconds: 500));
    }).catchError((onError) {
      print(onError);
    });
  }

  void getBillCurrentDay() {
    appDataHelper
        .getBillCurrentDay(Common.selectedShop["idShop"])
        .then((value) {
      print(value);
      _viewModel.listBill = value;
      baseView.updateUI({});
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void intiView(BaseView baseView) {
    this.baseView = baseView;
  }
}
