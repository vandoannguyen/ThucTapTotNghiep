import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/list_merchandis/ListMerchandisViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';

class ListMerchandisPresenter implements BasePresenter {
  BaseView _baseView;
  ListMerchandisViewModel _viewModel;

  ListMerchandisPresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
    this._baseView = baseView;
  }

  void getData() async {
    http.get(
        Common.rootUrlApi +
            "merchandise/list?idShop= ${Common.selectedShop["idShop"]}",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
        }).then((value) {
      var data = jsonDecode(value.body);

      _viewModel.categories = data.map((element) {
        element["selected"] = false;
        return element;
      }).toList();
      _viewModel.categories[0]["selected"] = true;
      _viewModel.selectedCategory = _viewModel.categories[0];
      _viewModel.selectedListMerchandise =
          _viewModel.selectedCategory["listMechandise"];
      _baseView.updateUI({});
    }).catchError((err) {
      print(err);
    });
  }
}
