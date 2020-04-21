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
  static final String LIST_BILL = "LIST_BILL";
  static final String DAY_OF_WEEK = "DAY_OF_WEEK";
  ListBillViewModel _viewModel;
  IAppDataHelper appDataHelper;

  static final String BUTTON_FILL = "BUTTON_FILL";

  void pressDonXuat() {
    _viewModel.isExportBill = true;

    var list =
        _viewModel.bills.where((element) => element["status"] == 1).toList();
    getSink(LIST_BILL).add(new BlocLoaded(list));
    getSink(BUTTON_FILL).add(new BlocLoaded(true));
  }

  void pressDonNhap() {
    _viewModel.isExportBill = false;
    var list =
        _viewModel.bills.where((element) => element["status"] == 0).toList();
    getSink(LIST_BILL).add(new BlocLoaded(list));
    getSink(BUTTON_FILL).add(new BlocLoaded(false));
  }

  ListBillPresenter(ListBillViewModel viewModel) : super() {
    _viewModel = viewModel;
    addStreamController(LIST_BILL);
    addStreamController(DAY_OF_WEEK);
    addStreamController(BUTTON_FILL);
    appDataHelper = new AppDataHelper();
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
            _viewModel.endDay = value;
            getSink(DAY_OF_WEEK).add(new BlocLoaded(
                {"firstDay": _viewModel.firstDay, "endDay": value}));
            getListBill(_viewModel.firstDay, value);
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
        dynamic list = _viewModel.bills
            .where((element) => element["status"] == 1)
            .toList();
        print(list.length);
        getSink(LIST_BILL).add(new BlocLoaded(list));
      } else {
        dynamic list = _viewModel.bills
            .where((element) => element["status"] == 0)
            .toList();
        getSink(LIST_BILL).add(new BlocLoaded(list));
      }
    }).catchError((err) {
      print(err);
    });
  }
}
