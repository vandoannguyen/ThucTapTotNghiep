import 'package:flutter/cupertino.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/billpage/BillPageViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import '../list_bill/ListBill.dart';

class BillPagePresenter extends BasePresenter {
  BillPageViewModel _viewModel;
  BaseView baseView;
  IAppDataHelper appDataHelper;

  var CURRENT_BILLS = "billscurrent";

  BillPagePresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
    addStreamController(CURRENT_BILLS);
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
    print("getBillCurrentDay");
    getSink(CURRENT_BILLS).add(new BlocLoading());
    appDataHelper
        .getBillByDay(
            Common.selectedShop["idShop"], DateTime.now(), DateTime.now(), 1)
        .then((value) {
      print(value);
      _viewModel.listBill = value;
      getSink(CURRENT_BILLS).add(new BlocLoaded(value));
//      baseView.updateUI({});
    }).catchError((onError) {
      getSink(CURRENT_BILLS).add(new BlocFailed(onError));
      print(onError);
    });
  }

  @override
  void intiView(BaseView baseView) {
    this.baseView = baseView;
  }
}
