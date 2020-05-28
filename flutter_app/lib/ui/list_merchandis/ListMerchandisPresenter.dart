import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/meschandis_detail/MechandisDetail.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'ListMerchandisView.dart';
import 'ListMerchandisViewModel.dart';

class ListMerchandisPresenter<V extends ListMerchandisView>
    extends BasePresenter<V> {
  IAppDataHelper appDataHelper;
  ListMerchandisViewModel _viewModel;

  static final String CATEGORY = "CATEGORY";
  static final String MERCHANDISE = "MERCHANDISE";
  static final String CLICK_CATEGORY = "CLICK_CATEGORY";

  ListMerchandisPresenter(this._viewModel) : super() {
    appDataHelper = new AppDataHelper();
    addStreamController(CATEGORY);
    addStreamController(MERCHANDISE);
    addStreamController(CLICK_CATEGORY);
  }

  void getData() async {
    getSink(CATEGORY).add(BlocLoading());
    appDataHelper
        .getMerchandisesByShop(Common.selectedShop["idShop"])
        .then((value) {
      _viewModel.merchandises = value;
      _viewModel.categories = Common.categories;
      _viewModel.categories = _viewModel.categories.map((element) {
        element["selected"] = false;
        return element;
      }).toList();
      _viewModel.categories[0]["selected"] = true;
      _viewModel.selectedCategory = _viewModel.categories[0];
      _viewModel.selectedListMerchandise = _viewModel.merchandises
          .where((element) =>
              element["idCategory"] ==
                  _viewModel.selectedCategory["idCategory"] &&
              element["status"] == 1)
          .toList();
      getSink(CATEGORY).add(BlocLoaded(_viewModel.selectedListMerchandise));
    }).catchError((err) {});
  }

  void addMerchandise(context) {
    IntentAnimation.intentNomal(
            context: context,
            screen: MerchandiseDetail(
              inputKey: MerchandiseDetail.CREATE,
            ),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 500))
        .then((value) {
      print(value);
      if (value != null && value == "ok") {
        getData();
      }
    });
  }

  void showScanBarCode(BuildContext context) {
    scan.scan().then((value) {
      dynamic selectedMerchandise = _viewModel.merchandises
          .firstWhere((element) => element["barcode"] == value);
      if (selectedMerchandise != null) {
        IntentAnimation.intentNomal(
            context: context,
            screen: MerchandiseDetail(
              inputKey: MerchandiseDetail.DETAIL,
              value: selectedMerchandise,
            ),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 800));
      }
    }).catchError((err) {});
  }

  void getMerchandise() {
    appDataHelper
        .getMerchandisesByShop(Common.selectedShop["idShop"])
        .then((value) {
      _viewModel.merchandises = value;
    }).catchError((err) {
      print(err);
    });
  }

  void merchandiseDetail(contex, index) {
    print(_viewModel.selectedListMerchandise[index]);
    IntentAnimation.intentNomal(
            context: contex,
            screen: MerchandiseDetail(
                inputKey: MerchandiseDetail.DETAIL,
                value: _viewModel.selectedListMerchandise[index]),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 500))
        .then((value) {
      getData();
      if (value != null && value != "") {
        if (value == "delete") {
          _viewModel.scaffState.currentState.showSnackBar(new SnackBar(
            content: Text("Xóa sản phẩm thành công"),
            elevation: 4,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
          ));
        }
      }
    });
  }
}
