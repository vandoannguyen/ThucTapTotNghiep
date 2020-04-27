import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'SearchSanPhamViewModel.dart';

class SearchSanPhamPresenter extends BasePresenter {
  BaseView _baseView;
  SearchSanPhamViewModel _viewModel;
  IAppDataHelper appDataHelper;

  String LIST_MERCHANDISE = "merchndises";

  SearchSanPhamPresenter(this._viewModel) : super() {
    appDataHelper = new AppDataHelper();
    addStreamController(LIST_MERCHANDISE);
  }

  @override
  void intiView(BaseView baseView) {
    this._baseView = baseView;
  }

  void getListSanPham() async {
    getSink(LIST_MERCHANDISE).add(BlocLoading());
    appDataHelper
        .getMerchandisesByShop(Common.selectedShop["idShop"])
        .then((value) {
      _viewModel.listSanPham = value;
      getSink(LIST_MERCHANDISE).add(BlocLoaded(value));
      print(_viewModel.listSanPham);
    }).catchError((err) {
      getSink(LIST_MERCHANDISE).add(BlocFailed(err));
      print(err);
    });
  }

  void onTextInputChange(String value) {
//    String a;
//    a.contains(other)
//    print(_viewModel.listSanPham);
    var list = _viewModel.listSanPham
        .where(
            (element) => _equalsIgnoreCase(element["nameMerchandise"], value))
        .toList();
    print(list);
    getSink(LIST_MERCHANDISE).add(new BlocLoaded(list));
  }

  bool _equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase().contains(string2?.toLowerCase());
  }
}
