import 'dart:async';
import 'dart:collection';

import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'HomePageView.dart';
import 'HomePageViewModel.dart';

class HomePagePresenter<V extends HomePageView> extends BasePresenter<V> {
  HomePageViewModel _viewModel;
  IAppDataHelper appDataHelper;
  HashMap<String, StreamController> _streamControl;

  String OVERLAY_IN_BILL = "inbill";
  String OVERLAY_OUT_BILL = "outBill";
  String BEST_SALE = "best sale";
  String WARNING = "warning";
  String WAREHOUSE = "warehouse";

  String DAY_OF_WEEK = "dfw";

  HomePagePresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
    addStreamController(OVERLAY_IN_BILL);
    addStreamController(OVERLAY_OUT_BILL);
    addStreamController(BEST_SALE);
    addStreamController(WARNING);
    addStreamController(WAREHOUSE);
    addStreamController(DAY_OF_WEEK);
  }

  void getDayOfWeek() {
    var curentDate = DateTime.now();
    curentDate = curentDate.subtract(Duration(
        hours: curentDate.hour,
        milliseconds: curentDate.millisecond,
        minutes: curentDate.minute,
        seconds: curentDate.second,
        microseconds: curentDate.microsecond));
    var firstDayOfWeek =
        curentDate.subtract(Duration(days: curentDate.weekday - 1));
    var endDayOfWeek =
        firstDayOfWeek.add(Duration(days: firstDayOfWeek.weekday + 5));
    _viewModel.firstDay = firstDayOfWeek;
    _viewModel.endDay = endDayOfWeek;
    getSink(DAY_OF_WEEK).add(
        new BlocLoaded({"fristDay": firstDayOfWeek, "endDay": endDayOfWeek}));
//    baseView.updateUI({});
  }

  void getBestSeller() {
    getSink(BEST_SALE).add(new BlocLoading());
    appDataHelper
        .getBestSeller(
            Common.selectedShop["idShop"],
            5,
            _viewModel.firstDay.toIso8601String().replaceFirst("T", " "),
            _viewModel.endDay.toIso8601String().replaceFirst("T", " "))
        .then((value) {
      _viewModel.bestSellers = value;
      getSink(BEST_SALE).add(new BlocLoaded(value));
    }).catchError((err) {
      getSink(BEST_SALE).add(new BlocFailed(err));
    });
  }

  void getWillBeEmpty() async {
    getSink(WARNING).add(new BlocLoading());
    appDataHelper
        .getWillBeEmpty(
            Common.selectedShop["idShop"], Common.selectedShop["warningCount"])
        .then((value) {
      _viewModel.marchandiseWillEmpty = value;
      getSink(WARNING).add(new BlocLoaded(value));
    }).catchError((err) {
      getSink(WARNING).add(new BlocFailed(err));
    });
  }

  void getBills() {
    getSink(OVERLAY_IN_BILL).add(BlocLoading());
    appDataHelper
        .getBillByDay(Common.selectedShop["idShop"], _viewModel.firstDay,
            _viewModel.endDay, 3)
        .then((onValue) {
      if (onValue != null && onValue != "") {
        _viewModel.bills = onValue;
        getSink(OVERLAY_IN_BILL).add(BlocLoaded(onValue));
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  V baseView;

  @override
  void intiView(V baseView) {
    this.baseView = baseView;
  }

  void getMerchandises() {
    getSink(WAREHOUSE).add(BlocLoading());
    appDataHelper
        .getMerchandisesByShop(Common.selectedShop["idShop"])
        .then((value) {
      print("on valu $value");
      var countMerchandise = 0;
      var totalPrice = 0;
      value.forEach((element) {
        countMerchandise += element["count"];
        totalPrice += element["inputPrice"];
      });
      getSink(WAREHOUSE)
          .add(BlocLoaded({"count": countMerchandise, "total": totalPrice}));
    }).catchError((err) {});
  }
}
