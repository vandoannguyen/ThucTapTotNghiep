import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/list_bill/ListBillView.dart';
import 'package:init_app/ui/list_bill/ListBillViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';

class ListBillPresenter<V extends ListBillView> extends BasePresenter<V> {
  static const String LIST_BILL = "LIST_BILL";
  static const String DAY_OF_WEEK = "DAY_OF_WEEK";
  static const String BUTTON_FILL = "BUTTON_FILL";
  static const String CHOSE_OPTION = "CHOSE_OPTION";
  ListBillViewModel _viewModel;
  IAppDataHelper appDataHelper;

  static const String DATE = "DATE";

  static const String PRICE = "PRICE";

  static const String DISCOUNT = "DISCOUNT";

  static const ORDER_STATUS = "ORDER_STATUS";

  ListBillPresenter(ListBillViewModel viewModel) : super() {
    _viewModel = viewModel;
    addStreamController(LIST_BILL);
    addStreamController(DAY_OF_WEEK);
    addStreamController(BUTTON_FILL);
    addStreamController(CHOSE_OPTION);
    addStreamController(ORDER_STATUS);
    appDataHelper = new AppDataHelper();
  }

  void pressDonXuat() {
    _viewModel.isExportBill = true;

    _viewModel.listFilled =
        _viewModel.bills.where((element) => element["status"] == 1).toList();
    sortList();
    getSink(LIST_BILL).add(new BlocLoaded(_viewModel.listFilled));
    getSink(BUTTON_FILL).add(new BlocLoaded(true));
  }

  void pressDonNhap() {
    _viewModel.isExportBill = false;
    _viewModel.listFilled =
        _viewModel.bills.where((element) => element["status"] == 0).toList();
    sortList();
    getSink(LIST_BILL).add(new BlocLoaded(_viewModel.listFilled));
    getSink(BUTTON_FILL).add(new BlocLoaded(false));
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
        new BlocLoaded({"firstDay": firstDayOfWeek, "endDay": endDayOfWeek}));
    getListBill(_viewModel.firstDay, _viewModel.endDay);
  }

  void pressToDate(BuildContext context) {
    _showDatePickerDialog(
        context: context,
        callBack: (value) {
          if (value != null) {
            if (_viewModel.firstDay.isBefore(value)) {
              _viewModel.endDay = value;
              getSink(DAY_OF_WEEK).add(new BlocLoaded(
                  {"firstDay": _viewModel.firstDay, "endDay": value}));
              getListBill(_viewModel.firstDay, value);
            }
          } else {
            baseView.showMess(false, "Vui lòng chọn lại ngày");
          }
        });
  }

  void _showDatePickerDialog({context, callBack}) {
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
        callBack(null);
      },
      onConfirm: (dateTime, List<int> index) {
        callBack(dateTime);
      },
    );
  }

  void pressFromDate(BuildContext context) {
    _showDatePickerDialog(
        context: context,
        callBack: (value) {
          if (value != null) {
            if (checkDate(value, _viewModel.endDay)) {
              _viewModel.firstDay = value;
              getSink(DAY_OF_WEEK).add(new BlocLoaded(
                  {"firstDay": value, "endDay": _viewModel.endDay}));
              getListBill(value, _viewModel.endDay);
            } else {
              baseView.showMess(false, "Vui lòng chọn lại ngày");
            }
          }
        });
  }

  bool checkDate(DateTime fristDay, DateTime endDay) {
    return fristDay.isBefore(endDay);
  }

  void getListBill(DateTime firstDay, DateTime endDay) {
    getSink(LIST_BILL).add(new BlocLoading());
    appDataHelper
        .getBillByDay(Common.selectedShop["idShop"], _viewModel.firstDay,
            _viewModel.endDay, 3)
        .then((value) {
      _viewModel.bills = value;
//      getSink(LIST_BILL).add(new BlocLoaded([]));
      print(value);
      if (_viewModel.isExportBill) {
        _viewModel.listFilled = _viewModel.bills
            .where((element) => element["status"] == 1)
            .toList();
        print(_viewModel.listFilled.length);
        sortList();
        getSink(LIST_BILL).add(new BlocLoaded(_viewModel.listFilled));
      } else {
        _viewModel.listFilled = _viewModel.bills
            .where((element) => element["status"] == 0)
            .toList();
        List<int> munm = [3, 6, 1, 4, 3, 5];
        munm.sort((a, b) => a - b);
        print("${munm}");
        sortList();
        getSink(LIST_BILL).add(new BlocLoaded(_viewModel.listFilled));
      }
    }).catchError((err) {
      print(err);
    });
  }

  void pressFillOption(BuildContext context) async {
    var result = await showDialog(
        context: context,
        builder: (context) => Dialog(
              elevation: 4,
              child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, DATE);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                elevation: 4,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  child: Text("Ngày tạo"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, PRICE);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                elevation: 4,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  child: Text("Giá trị"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, DISCOUNT);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                elevation: 4,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  child: Text("Chiết khấu"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ));
    if (result != null) {
      print(result);
      getSink(CHOSE_OPTION).add(new BlocLoaded(result == DATE
          ? "Ngày tạo"
          : result == PRICE ? "Giá trị" : "Chiết khấu"));
      _viewModel.choseOption = result;
      sortList();
      getSink(LIST_BILL).add(new BlocLoaded(_viewModel.listFilled));
    }
  }

  void sortList() {
    if (_viewModel.listFilled != null && _viewModel.listFilled != []) {
      _viewModel.listFilled.sort((a, b) {
        switch (_viewModel.choseOption) {
          case DATE:
            {
              int re = DateTime.parse(a["dateCreate"])
                      .isBefore(DateTime.parse(b["dateCreate"]))
                  ? -1
                  : 1;
              return _viewModel.order == "up" ? re : re * -1;
            }

          case PRICE:
            {
              int re = a["totalPrice"] - b["totalPrice"] as int;
              return _viewModel.order == "up" ? re : re * -1;
            }
          case DISCOUNT:
            {
              int re = a["discount"] - b["discount"] as int;
              return _viewModel.order == "up" ? re : re * -1;
            }
        }
      });
    }
  }

  void pressOrder() {
    if (_viewModel.order == "up")
      _viewModel.order = "down";
    else
      _viewModel.order = "up";
    sortList();
    getSink(LIST_BILL).add(new BlocLoaded(_viewModel.listFilled));
    getSink(ORDER_STATUS).add(new BlocLoaded(_viewModel.order));
  }
}
