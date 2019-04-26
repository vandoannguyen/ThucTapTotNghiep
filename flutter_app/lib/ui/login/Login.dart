import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/login/LoginView.dart';
import 'package:init_app/ui/shop/ShopDetail.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'LoginPresenter.dart';
import 'LoginViewModel.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginView {
  LoginPresenter<LoginView> _presenter;
  LoginViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    _viewModel = new LoginViewModel();
    _presenter = new LoginPresenter<LoginView>(_viewModel);
    _presenter.intiView(this);
    _presenter.getRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    print("build demo");
    Common.heightOfScreen = MediaQuery.of(context).size.height;
    Common.widthOfScreen = MediaQuery.of(context).size.width;
    _viewModel.context = context;
    return Scaffold(
      key: _viewModel.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bluebackground.png"),
                  fit: BoxFit.fill)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: Common.heightOfScreen / 8,
                  ),
                  Container(
                    height: Common.heightOfScreen / 6,
                    child: Text(
                      "SmartShop\nĐăng nhập",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onFieldSubmitted: (value) {
                        _presenter.usernameSummit();
                      },
                      style: inputStyle(),
                      controller: _viewModel.userNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                        ),
                        labelText: "Tên người dùng",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      focusNode: _viewModel.fcPass,
                      obscureText: _viewModel.isHide,
                      style: inputStyle(),
                      controller: _viewModel.passwordController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                showOrHidePass();
                              },
                              icon: _viewModel.isHide
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                          labelText: "Mật khẩu"),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _viewModel.isCheck,
                          onChanged: (value) {
                            setState(() {
                              _viewModel.isCheck = value;
                            });
                            _presenter.rememberMe(value);
                          },
                          checkColor: Colors.white,
                          activeColor: Colors.lightBlue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ghi nhớ đăng nhập",
                          style: TextStyle(color: Colors.grey[200]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            login(context);
                          },
                          child: Container(
                            width: Common.widthOfScreen / 2.5,
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlueAccent,
                                      Colors.lightBlue,
                                      Colors.blue,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.bottomRight),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[600],
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(2, 2)),
                                ]),
                            alignment: Alignment.center,
                            child: Text(
                              "Đăng nhập",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            register(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.orangeAccent,
                                      Colors.orange,
                                      Colors.deepOrange,
                                    ],
                                    stops: [
                                      0.3,
                                      0.5,
                                      1
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.bottomRight),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[600],
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(2, 2)),
                                ]),
                            alignment: Alignment.center,
                            child: Text(
                              "Đăng ký",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 15,
                child: GestureDetector(
                  onTap: () {
                    register(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Chưa có tài khoản? Đăng ký.",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 55,
                child: Visibility(
                  visible: _viewModel.isLoading,
                  child: Container(
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/icons/loading.gif")),
                ),
              )
            ],
          )),
    );
  }

  void login(BuildContext context) {
    _presenter.postLogin(context, {
      "username": _viewModel.userNameController.text,
      "password": _viewModel.passwordController.text,
    });
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
    setState(() {});
  }

  register(context) {
    _presenter.register(context);
  }

  inputStyle() {
    return TextStyle(
        color: Colors.grey[600], fontSize: 18, fontWeight: FontWeight.w400);
  }

  void showOrHidePass() {
    setState(() {
      _viewModel.isHide = !_viewModel.isHide;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _presenter.dispose();
  }

  @override
  void showSnackBar({key, message}) {
    if (key == "message") {
      _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
          elevation: 4,
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          content: Container(
            child: Text(
              message.toString(),
              style: TextStyle(color: Colors.white),
            ),
          )));
    } else {
      _viewModel.scaffoldKey.currentState.showSnackBar(
        SnackBar(
          elevation: 4,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          content: Container(
            height: 35,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Chưa có cửa hàng"),
                ),
                GestureDetector(
                  onTap: () {
                    print("okTab");
                    IntentAnimation.intentNomal(
                        context: context,
                        screen: ShopDetail(
                          keyCheck: Common.KEY_CHECK_CREATE_SHOP,
                        ),
                        option: IntentAnimationOption.RIGHT_TO_LEFT,
                        duration: Duration(milliseconds: 500));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 60,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Thêm",
                      style: TextStyle(color: Colors.blue),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white54,
                              blurRadius: 3,
                              offset: Offset(2, 2))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
