import 'package:flutter/material.dart';
import 'package:init_app/login/LoginPresenter.dart';
import 'package:init_app/login/LoginViewModel.dart';
import 'package:init_app/utils/BaseView.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with TickerProviderStateMixin
    implements BaseView {
  LoginPresenter _presenter;
  LoginViewModel _viewModel;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _viewModel.controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _viewModel = new LoginViewModel();
    _presenter = new LoginPresenter();
    _presenter.intiView(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel.controller = AnimationController(
      vsync: this,
    )..animateTo(1, duration: Duration(milliseconds: 500));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          color: Colors.blue,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: height / 8,
                  ),
                  SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: const Offset(0, 0),
                      ).animate(_viewModel.controller),
                      child: Container(
                        height: height / 6,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.fill,
                        ),
                      )),
                  FadeTransition(
                      opacity: Tween(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(_viewModel.controller),
                      child: Container(
                          padding:
                              EdgeInsets.only(left: 50, right: 50, top: 50),
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Card(
                                  elevation: 4,
                                  borderOnForeground: true,
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: TextField(
                                            controller:
                                                _viewModel.userNameController,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: "Tên người dùng"),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.grey,
                                          height: 0.5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: TextField(
                                            controller:
                                                _viewModel.passwordController,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: "Mật khẩu"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(bottom: 20),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 30,
                                right: 30,
                                child: GestureDetector(
                                  onTap: () {
                                    login(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    alignment: Alignment.center,
                                    height: 50,
                                    child: Text(
                                      "Đăng nhập",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))),
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
              )
            ],
          )),
    );
  }

  void login(BuildContext context) {
    _presenter.postLogin({
      "username": _viewModel.userNameController.text,
      "password": _viewModel.passwordController.text
    });
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }

  register(context) {
//    Navigator.of(context)
//        .push(MaterialPageRoute(builder: (BuildContext context) => Register()));
    _presenter.register(context);
  }
}
