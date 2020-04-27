import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/category/Category.dart';
import 'package:init_app/ui/personnel/Personnel.dart';
import 'package:init_app/ui/register/Register.dart';
import 'package:init_app/ui/shop/ShopDetail.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'MoreView.dart';
import 'MoreViewModel.dart';

class MorePresenter<V extends MoreView> extends BasePresenter<V> {
  MoreViewModel _viewModel;
  IAppDataHelper appDataHelper;

  MorePresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  void changePass(context) {
//    _viewModel.fcConfirm.dispose();
    if (_viewModel.formKey.currentState.validate()) {
      Navigator.pop(context);
      _postChangePass();
    }
  }

  void _postChangePass() {
//    print(Common.user["idUser"]);
    _viewModel.isLoading = true;
    baseView.updateUI({});
    appDataHelper
        .updatePassword(Common.user["idUser"], _viewModel.newPass.text)
        .then((value) {
      _viewModel.isLoading = false;
      baseView.updateUI({});
      showSnackBar(color: Colors.blue, mess: "Đổi mật khẩu thành công");
    }).catchError((err) {
      showSnackBar(
          color: Colors.red, mess: "Đổi mật khẩu không thành công");
      print(err);
      _viewModel.isLoading = false;
      baseView.updateUI({});
      showSnackBar(color: Colors.red, mess: err.toString());
    });
  }

  void showSnackBar({MaterialColor color, String mess}) {
    _viewModel.scaffolKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      duration: Duration(seconds: 10),
      content: Text(
        mess,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  void dipose() {
    if (_viewModel.fcConfirm != null) _viewModel.fcConfirm.dispose();
    if (_viewModel.fcNewPass != null) _viewModel.fcNewPass.dispose();
  }

  String validateNewPass(String value) {
    if (_viewModel.newPass.text == "") return "Nhập thiếu";
    if (_viewModel.confirmPass.text != _viewModel.newPass.text) {
      return "Mật khẩu xác thực không trung khớp";
    }
  }

  String validateComfirmPass(String value) {
    if (_viewModel.confirmPass.text == "") return "Nhập thiếu";
    if (_viewModel.confirmPass.text != _viewModel.newPass.text) {
      return "Mật khẩu xác thực không trung khớp";
    }
  }

  String validateCurrentPass(String value) {
    print(Common.user["password"] + "1234567890");
    if (_viewModel.curentPass.text != Common.user["password"])
      return "Mật khẩu không đúng";
  }

  void intentThongTinCuaHang(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: ShopDetail(
          keyCheck: "detail",
          value: Common.selectedShop,
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }

  void listNhanVien(context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: Personnel(),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }

  void intentThemCuaHang(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: ShopDetail(
          keyCheck: "create",
          value: Common.selectedShop,
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }

  void showDialogChangeShop(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Danh sách loại mặt hàng"),
              actions: <Widget>[
                GestureDetector(
                  child: Container(
                    color: Colors.transparent,
                    height: 40,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Text("THÊM"),
                  ),
                )
              ],
            ));
  }

  void intentLoaiMatHang(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: Category(),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }

  @override
  V baseView;

  void clickAccountDetail(context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: Register(Register.DETAIL),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }
}
