import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
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
  String MERCHANDISE_NULL = "MERCHANDISE_NULL";

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
//    getSink(DAY_OF_WEEK).add(
//        new BlocLoaded({"firstDay": firstDayOfWeek, "endDay": endDayOfWeek}));
    baseView.updateUI({});
  }

  void getBestSeller() {
    getSink(BEST_SALE).add(new BlocLoading());
    appDataHelper
        .getBestSeller(
            Common.selectedShop["idShop"],
            10,
            _viewModel.firstDay.toIso8601String().replaceFirst("T", " "),
            _viewModel.endDay.toIso8601String().replaceFirst("T", " "))
        .then((value) {
      if (value.length > 0)
        _viewModel.bestSellers =
            value.where((element) => element["status"] == 1).toList();
      getSink(BEST_SALE).add(new BlocLoaded(_viewModel.bestSellers));
    }).catchError((err) {
      getSink(BEST_SALE).add(new BlocFailed(err));
    });
  }

  void getWillBeEmpty() async {
    getSink(WARNING).add(new BlocLoading());
    int warningCoutn = Common.selectedShop["warningCount"];
    if (warningCoutn == null) {
      warningCoutn = 10;
    }
    appDataHelper
        .getWillBeEmpty(Common.selectedShop["idShop"], warningCoutn)
        .then((value) {
      print(value);
      if (value.length > 0)
        _viewModel.marchandiseWillEmpty =
            value.where((element) => element["status"] == 1).toList();
      print(_viewModel.marchandiseWillEmpty[0]);
      getSink(WARNING).add(new BlocLoaded(_viewModel.marchandiseWillEmpty));
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
        var countBillIn = 0,
            countBillOut = 0,
            totalIn = 0,
            totalInReal = 0,
            totalOut = 0,
            totalOutReal = 0;
        _viewModel.bills.forEach((element) {
          if (element["status"] == 0) {
            countBillIn++;
            totalIn += element["totalPrice"];
            totalInReal += element["totalPrice"] - element["discount"];
          } else {
            countBillOut++;
            totalOut += element["totalPrice"];
            totalOutReal += element["totalPrice"] - element["discount"];
          }
        });
        var data = {
          "countBillIn": countBillIn,
          "countBillOut": countBillOut,
          "totalIn": totalIn,
          "totalInReal": totalInReal,
          "totalOut": totalOut,
          "totalOutReal": totalOutReal
        };
        getSink(OVERLAY_IN_BILL).add(BlocLoaded(data));
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
      if (value.length == 0) {
        showSnackBar();
      }
      value.forEach((element) {
        countMerchandise += element["count"];
        totalPrice += element["inputPrice"] * element["count"];
      });
      getSink(WAREHOUSE)
          .add(BlocLoaded({"count": countMerchandise, "total": totalPrice}));
    }).catchError((err) {});
  }

  void shopNameClick(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            elevation: 4,
            title: Text('Danh sách cửa hàng'),
            content: Container(
              height: 200,
              width: 200,
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: Common.shops.length,
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          Common.selectedShop = Common.shops[index];
                          getDayOfWeek();
                          getBestSeller();
                          getBills();
                          getWillBeEmpty();
                          getMerchandises();
                          getPersonnels(Common.selectedShop["idShop"]);
                          getCategories();
                          Navigator.pop(context);
                          baseView.updateUI({});
                        },
                        child: ItemShop(Common.shops[index]),
                      )),
            ));
      },
    );
  }

  void getPersonnels(selectedShop) {
    appDataHelper.getPersonnels(selectedShop).then((value) {
      print("${value}");
      Common.personnels = value;
    }).catchError((err) {
      print(err);
    });
  }

  void onClickFromDate(context) {
    const String MIN_DATETIME = '1998-01-01';
    const String MAX_DATETIME = '2050-12-31';
    const String INIT_DATETIME = '2020-04-13';
    DateTime _dateTime;
    String _format = 'yyyy-MMMM-dd';
    DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
    _dateTime = DateTime.parse(INIT_DATETIME);
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        titleHeight: 30,
        confirm: Icon(
          Icons.done,
          color: Colors.blue,
        ),
        cancel: Icon(
          Icons.close,
          color: Colors.red,
        ),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onClose: () => {},
      onCancel: () => {},
      onChange: (dateTime, List<int> index) {
        print(dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        _viewModel.firstDay = dateTime;
        getSink(DAY_OF_WEEK).add(new BlocLoaded(
            {"firstDay": dateTime, "endDay": _viewModel.endDay}));
        getBestSeller();
        getBills();
      },
    );
  }

  void onClickToDate(context) {
    const String MIN_DATETIME = '1998-01-01';
    const String MAX_DATETIME = '2050-12-31';
    const String INIT_DATETIME = '2020-04-13';
    DateTime _dateTime;
    String _format = 'yyyy-MMMM-dd';
    DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
    _dateTime = DateTime.parse(INIT_DATETIME);
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        titleHeight: 30,
        confirm: Icon(
          Icons.done,
          color: Colors.blue,
        ),
        cancel: Icon(
          Icons.close,
          color: Colors.red,
        ),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
      locale: _locale,
      onClose: () => print(_dateTime),
      onCancel: () => print(_dateTime),
      onChange: (dateTime, List<int> index) {
        print(dateTime);
      },
      onConfirm: (dateTime, List<int> index) {
        _viewModel.endDay = dateTime;
        getSink(DAY_OF_WEEK).add(new BlocLoaded(
            {"firstDay": _viewModel.firstDay, "endDay": dateTime}));
        getBestSeller();
        getBills();
      },
    );
  }

  void getCategories() {
    appDataHelper.getCategories(Common.selectedShop["idShop"]).then((value) {
      Common.categories = value;
    }).catchError((err) {
      print(err);
    });
  }

  void showSnackBar() {
    print("000000000000000");
    _viewModel.scaffKeyHomePage.currentState.showSnackBar(new SnackBar(
      content: Text(
        "Cửa hàng chưa có mặt hàng nào",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 4,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 10),
    ));
  }
}

class ItemShop extends StatelessWidget {
  dynamic shop;

  ItemShop(this.shop);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 4,
      child: Container(
        child: Container(
          width: 250,
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/icons/def_store.png",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      shop["name"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      shop["address"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
