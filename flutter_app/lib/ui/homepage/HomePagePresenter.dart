import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BasePresenter.dart';

import 'HomePageView.dart';
import 'HomePageViewModel.dart';

class HomePagePresenter<V extends HomePageView> implements BasePresenter<V> {
  HomePageViewModel _viewModel;

  HomePagePresenter(this._viewModel);

  void getHangBanChay() {
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
    print(firstDayOfWeek.toIso8601String().replaceFirst("T", " "));
    print(endDayOfWeek.toIso8601String().replaceFirst("T", " "));
    http
        .post("${Common.rootUrlApi}merchandise/getbestseller",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode({
              "idShop": Common.selectedShop["idShop"],
              "limits": 5,
              "fromDate":
                  firstDayOfWeek.toIso8601String().replaceFirst("T", " "),
              "toDate": endDayOfWeek.toIso8601String().replaceFirst("T", " ")
            }))
        .then((value) {
      _viewModel.bestSellers = jsonDecode(value.body);
      baseView.updateBestSeller(_viewModel.bestSellers);
    }).catchError((err) {
      print(err);
    });
  }

  void getHangSapHet() async {
    var result = await http.post(
        "${Common.rootUrlApi}merchandise/getMerchandisewillempty",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode({
          "idShop": Common.selectedShop["idShop"],
          "warningCount": Common.selectedShop["warningCount"]
        }));
    print(result.body);
    if (result != null) {
      _viewModel.marchandiseWillEmpty = jsonDecode(result.body);
      print(_viewModel.marchandiseWillEmpty);
      baseView.updateUI({});
    }
  }

  @override
  V baseView;

  @override
  void intiView(V baseView) {
    this.baseView = baseView;
  }
}
