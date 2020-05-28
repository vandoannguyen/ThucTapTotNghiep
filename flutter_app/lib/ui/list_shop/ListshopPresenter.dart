import 'dart:async';

import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/list_shop/ListShopViewModel.dart';
import 'package:init_app/ui/login/Login.dart';
import 'package:init_app/ui/shop/ShopDetail.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'ListShopView.dart';

class ListShopViewPresenter<V extends ListShopView> extends BasePresenter<V> {
  static const String LOADING = "LOADING";
  IAppDataHelper dataHelper;
  ListShopViewModel _viewModel;
  IAppDataHelper appDataHelper;
  void deleteShop(context, idShop) async {
    getSink(LOADING).add(new BlocLoading());
    dataHelper.deleteShop(idShop).then((value) {
      _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text(value),
        backgroundColor: Colors.blue,
      ));
      Common.shops.removeWhere((element) => element["idShop"] == idShop);

      if (Common.shops.length == 0) {
        int t = 3;
        Timer timer = Timer.periodic(Duration(milliseconds: 300), (time) {
          if (t > 0)
            t--;
          else {
            time.cancel();
            IntentAnimation.intentPushReplacement(
                context: context,
                screen: Login(),
                option: IntentAnimationOption.RIGHT_TO_LEFT,
                duration: Duration(seconds: 1));
          }
        });
      }
    }).catchError((err) {
      _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text(err),
        backgroundColor: Colors.red,
      ));
    });
  }

  void intentThemCuaHang(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: ShopDetail(
          keyCheck: "create",
          value: Common.selectedShop,
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500)).then((value){
      getListShop();
    });
  }

  ListShopViewPresenter(ListShopViewModel _viewModel) : super() {
    appDataHelper = new AppDataHelper();
    this._viewModel = _viewModel;
    dataHelper = new AppDataHelper();
    addStreamController(LOADING);
  }

  void getListShop() {
    getSink(LOADING).add(new BlocLoading());
    appDataHelper.getListShop(Common.user["idUser"]).then((value) {
      Common.shops = value;
      getSink(LOADING).add(new BlocLoaded({}));
    }).catchError((err) {
      getSink(LOADING).add(new BlocLoaded({}));
      print(err);
    });
  }
}
