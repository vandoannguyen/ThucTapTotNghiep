import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/search_merchandis/SearchSanPhamView.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';

import 'SearchSanPhamViewModel.dart';

class SearchSanPhamPresenter<V extends SearchSanPhamView>
    extends BasePresenter<V> {
  BaseView _baseView;
  SearchSanPhamViewModel _viewModel;
  IAppDataHelper appDataHelper;

  SearchSanPhamPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  @override
  void intiView(BaseView baseView) {
    this._baseView = baseView;
  }

  void getListSanPham(idCuaHang) async {
    print('Bearer ' + Common.loginToken);
    appDataHelper.getMerchandisesByShop(idCuaHang).then((value) {
      _viewModel.listSanPham = value;
      _baseView.updateUI(dynamic);
      print(_viewModel.listSanPham);
    }).catchError((err) {
      print(err);
    });
  }
}
