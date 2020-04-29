import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/common/CustomButton.dart';
import 'package:init_app/ui/login/Login.dart';
import 'package:init_app/ui/more/MorePresenter.dart';
import 'package:init_app/ui/more/MoreView.dart';
import 'package:init_app/ui/more/MoreViewModel.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'ChangePassDialog.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> implements MoreView {
  MoreViewModel _viewModel;
  MorePresenter<MoreView> _presenter;

  @override
  void initState() {
    // TODO: implement initState
    _viewModel = new MoreViewModel();
    _presenter = new MorePresenter<MoreView>(_viewModel);
    _presenter.intiView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _viewModel.scaffolKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Thông tin"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(80))),
                        child: Common.user["image"] == null ||
                                Common.user["image"] == ""
                            ? Image.asset(
                                "assets/images/defAvatar.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.fill,
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: "assets/images/defAvatar.png",
                                image: Common.rootUrl + Common.user["image"],
                                height: 80,
                                width: 80,
                                fit: BoxFit.fill,
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Common.user["name"],
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(Common.user["email"])
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Common.user["idRole"] == 2
                          ? Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    nhanVien(context);
                                  },
                                  iconLeft: Icons.people,
                                  colorIconLeft: Colors.blue,
                                  lable: "Quản lý nhân viên",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    color: Colors.transparent,
                                    child: CustomButton(
                                        iconLeft: Icons.perm_contact_calendar,
                                        colorIconLeft: Colors.blue,
                                        lable: "Thông tin tài khoản",
                                        buttonTextStyle: buttonTextStyle(),
                                        onTap: () {
                                          _presenter
                                              .clickAccountDetail(context);
                                        })),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    _presenter.intentThemCuaHang(context);
                                  },
                                  perfixIcon: Image.asset(
                                    "assets/icons/shop.png",
                                    width: 25,
                                    height: 25,
                                  ),
                                  colorIconLeft: Colors.blue,
                                  lable: "Thêm cửa hàng",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    _presenter.intentThongTinCuaHang(context);
                                  },
                                  iconLeft: Icons.store,
                                  colorIconLeft: Colors.blue,
                                  lable: "Thông tin cửa hàng",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    _presenter.changeShop(context);
                                  },
                                  iconLeft: Icons.sync,
                                  colorIconLeft: Colors.blue,
                                  lable: "Đổi cửa hàng",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    _presenter.intentLoaiMatHang(context);
                                  },
                                  iconLeft: Icons.category,
                                  colorIconLeft: Colors.blue,
                                  lable: "Loại mặt hàng",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    showDialogChangePass(context);
                                  },
                                  iconLeft: Icons.vpn_key,
                                  colorIconLeft: Colors.blue,
                                  lable: "Đổi mật khẩu",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    IntentAnimation.intentPushReplacement(
                                        context: context,
                                        screen: Login(),
                                        exitScreen: widget,
                                        option: IntentAnimationOption
                                            .EXIT_LEFT_TO_RIGHT,
                                        duration: Duration(milliseconds: 500));
                                  },
                                  iconLeft: Icons.settings_power,
                                  colorIconLeft: Colors.blue,
                                  lable: "Đăng xuất",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: CustomButton(
                                      iconLeft: Icons.perm_contact_calendar,
                                      colorIconLeft: Colors.blue,
                                      lable: "Thông tin tài khoản",
                                      buttonTextStyle: buttonTextStyle(),
                                      onTap: () {
                                        _presenter.clickAccountDetail(context);
                                      }),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    _presenter.intentThongTinCuaHang(context);
                                  },
                                  iconLeft: Icons.store,
                                  colorIconLeft: Colors.blue,
                                  lable: "Thông tin cửa hàng",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    showDialogChangePass(context);
                                  },
                                  iconLeft: Icons.vpn_key,
                                  colorIconLeft: Colors.blue,
                                  lable: "Đổi mật khẩu",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    child: CustomButton(
                                  onTap: () {
                                    IntentAnimation.intentPushReplacement(
                                        context: context,
                                        screen: Login(),
                                        exitScreen: widget,
                                        option: IntentAnimationOption
                                            .EXIT_LEFT_TO_RIGHT,
                                        duration: Duration(milliseconds: 500));
                                  },
                                  iconLeft: Icons.settings_power,
                                  colorIconLeft: Colors.blue,
                                  lable: "Đăng xuất",
                                  buttonTextStyle: buttonTextStyle(),
                                )),
                              ],
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: _viewModel.isLoading,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 80),
              color: Colors.transparent,
              child: Image.asset(
                "assets/icons/loading.gif",
                width: 40,
                height: 40,
              ),
            ),
          )
        ],
      ),
    );
  }

  buttonTextStyle() {
    return TextStyle();
  }

  void nhanVien(context) {
    _presenter.listNhanVien(context);
  }

  void showDialogChangePass(context) {
    print("showDialog");
    showDialog(
        context: context,
        builder: (context) =>
            ChangePassDialog(_viewModel, _presenter, context));
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _presenter.dipose();
  }
}
