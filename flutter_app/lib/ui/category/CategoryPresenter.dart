import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/category/CategoryViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'Category.dart';
import 'CategoryView.dart';

class CategoryPresenter<V extends CategoryView> extends BasePresenter<V> {
  CategoryViewModel _viewModel;
  IAppDataHelper appDataHelper;

  var LIST_CATEGORY = "listCategory";

  CategoryPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
    addStreamController(LIST_CATEGORY);
  }

  void getCategory() {
    getSink(LIST_CATEGORY).add(new BlocLoading());
    appDataHelper
        .getCategories(Common.selectedShop["idShop"].toString())
        .then((value) {
      print(value);
      _viewModel.danhSachLoaiMatHang = value;
      Common.categories = value;
      getSink(LIST_CATEGORY).add(BlocLoaded(value));
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

  void deldeteCategory(idCategory, idNoCategory) {
    appDataHelper
        .deleteCategory(idCategory, idNoCategory, Common.selectedShop["idShop"])
        .then((value) {
      print(value);
      getCategory();
      baseView.showSnackBar(
        keyInput: Category.API_SUCCESS,
        mess: "Xóa thành công",
      );
    }).catchError((onError) {
      baseView.showSnackBar(keyInput: "er", mess: "Xóa không thành công");
    });
  }

  void update(idCategory, String text) {
    appDataHelper.updateCategory(idCategory, text).then((value) {
      baseView.showSnackBar(
          keyInput: Category.API_SUCCESS, mess: "Sửa thành công");
      getCategory();
    }).catchError((err) {
      print(err);
    });
  }
}
