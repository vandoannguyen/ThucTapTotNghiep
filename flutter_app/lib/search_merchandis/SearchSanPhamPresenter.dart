import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';

import 'SearchSanPhamViewModel.dart';

class SearchSanPhamPresenter implements BasePresenter {
  BaseView _baseView;
  SearchSanPhamViewModel _viewModel;

  SearchSanPhamPresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    this._baseView = baseView;
  }

  void getListSanPham(idCuaHang) async {
    print('Bearer ' + Common.loginToken);
    _viewModel.listSanPham = await http.get(
      "${Common.rootUrl}merchandise/listMerchandise?idCuaHang=1",
      headers: {
        "Authorization": 'Bearer ' + Common.loginToken,
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      },
    ).then((response) {
      print(response.body);
    }).catchError((err) {
      print(err);
    });
  }
}
