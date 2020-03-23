import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/category/CategoryViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';

import 'Category.dart';
import 'CategoryView.dart';

class CategoryPresenter<V extends CategoryView> extends BasePresenter<V> {
  CategoryViewModel _viewModel;
  IAppDataHelper appDataHelper;

  CategoryPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  void getCategory() {
    appDataHelper
        .getCategories(Common.selectedShop["idShop"].toString())
        .then((value) {
      print(value);
      _viewModel.danhSachLoaiMatHang = value;
      baseView.updateUI({});
    }).catchError((err) {
      print(err);
    });
  }

  void addCategory(String text) {
    appDataHelper
        .addCategory(Common.selectedShop["idShop"], text)
        .then((value) {
      baseView.showSnackBar(
          keyInput: Category.API_SUCCESS, mess: "Thêm thành công");
      getCategory();
    }).catchError((err) {
      print(err);
    });
  }
}
