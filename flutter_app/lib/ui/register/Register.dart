import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'RegisterPresenter.dart';
import 'RegisterView.dart';
import 'RegisterViewModel.dart';

class Register extends StatefulWidget {
  static final String REGISTER = "REGISTER";
  static final String ADD_PERSONEL = "ADD_PERSONEL";
  static final String DETAIL = "DETAIL";
  String keyCheck;
  dynamic user;

  Register(this.keyCheck, {this.user});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements RegisterView {
  RegisterPresenter _presenter;
  RegisterViewModel _viewModel;
  GlobalKey<FormState> _key;
  GlobalKey<ScaffoldState> _keyS;

  @override
  void initState() {
    _key = new GlobalKey();
    _keyS = new GlobalKey();
    _viewModel = new RegisterViewModel();
    _viewModel.keyCheck = widget.keyCheck;
    _presenter = new RegisterPresenter(_viewModel);
    _presenter.intiView(this);
    if (widget.keyCheck == Register.DETAIL) {
      if (widget.user != null) {
        _viewModel.user = widget.user;
        _viewModel.fullNameController.text = widget.user["name"];
        _viewModel.usernameController.text = widget.user["username"];
        _viewModel.passwordController.text = widget.user["password"];
        _viewModel.emailController.text = widget.user["email"];
        _viewModel.comfirmPassVisibile = false;
        _viewModel.enableEdit = false;
        _viewModel.personnelIsActive = widget.user["status"] == 1;
      } else {
//        _viewModel.user = Common.user;
        _viewModel.fullNameController.text = Common.user["name"];
        _viewModel.usernameController.text = Common.user["username"];
        _viewModel.passwordController.text = Common.user["password"];
        _viewModel.emailController.text = Common.user["email"];
        _viewModel.comfirmPassVisibile = false;
        _viewModel.enableEdit = false;
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel.context = context;
    return Stack(
      children: <Widget>[
        Container(
            height: Common.heightOfScreen,
            child: Image.asset(
              "assets/images/background_register.png",
              fit: BoxFit.fill,
            )),
        Scaffold(
            backgroundColor: Colors.transparent,
            key: _keyS,
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context, _viewModel.enableEdit ? "ok" : null);
                          },
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.only(left: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black54,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        !_viewModel.enableEdit &&
                                widget.keyCheck == Register.DETAIL
                            ? GestureDetector(
                                onTap: () {
                                  _presenter.setEnableEdit();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 15),
                    child: Text(
                      _viewModel.keyCheck == Register.REGISTER
                          ? "Đăng ký\nTài khoản mới"
                          : widget.keyCheck == Register.ADD_PERSONEL
                              ? "Thêm\nNhân viên"
                              : "Thông tin\n tài khoản",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (_viewModel.enableEdit) {
                          setImage();
                        }
                      },
                      child: avatar()),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 0, left: 20, right: 20),
                              child: TextFormField(
                                enabled: _viewModel.enableEdit,
                                scrollPadding: EdgeInsets.only(bottom: 0),
                                maxLines: 1,
                                onFieldSubmitted: (value) {
                                  _presenter.nameSummit();
                                },
                                validator: _validateName,
                                style: inputStyle(),
                                controller: _viewModel.fullNameController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      size: prefixIconSize(),
                                    ),
                                    labelText: "Họ và tên"),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 0, left: 20, right: 20),
                              child: TextFormField(
                                enabled: _viewModel.enableEdit,
                                scrollPadding: EdgeInsets.only(bottom: 0),
                                focusNode: _viewModel.fcEmail,
                                onFieldSubmitted: (value) {
                                  _presenter.emailSummit();
                                },
                                keyboardType: TextInputType.emailAddress,
                                validator: _validateEmail,
                                style: inputStyle(),
                                controller: _viewModel.emailController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      size: prefixIconSize(),
                                    ),
                                    labelText: "Email"),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 0, left: 20, right: 20),
                              child: TextFormField(
                                enabled: _viewModel.enableEdit,
                                scrollPadding: EdgeInsets.only(bottom: 0),
                                focusNode: _viewModel.fcUsername,
                                onFieldSubmitted: (value) {
                                  _presenter.userNameSummit();
                                },
                                validator: _validateUsername,
                                style: inputStyle(),
                                controller: _viewModel.usernameController,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      size: prefixIconSize(),
                                    ),
                                    labelText: "UserName"),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  bottom: 0, left: 20, right: 20),
                              child: TextFormField(
                                enabled: _viewModel.enableEdit,
                                focusNode: _viewModel.fcPassword,
                                onFieldSubmitted: (value) {
                                  _presenter.passSumit();
                                },
                                validator: _validatePassword,
                                keyboardType: TextInputType.text,
                                controller: _viewModel.passwordController,
                                obscureText: !_viewModel.passwordVisible,
                                //This will obscure text dynamically
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: prefixIconSize(),
                                  ),
                                  labelText: 'Mật khẩu',
                                  // Here is key idea
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _viewModel.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                      size: prefixIconSize(),
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _viewModel.passwordVisible =
                                            !_viewModel.passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Visibility(
                              visible: _viewModel.comfirmPassVisibile ||
                                  _viewModel.enableEdit,
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: 0, left: 20, right: 20),
                                child: TextFormField(
                                  focusNode: _viewModel.fcConfirmPass,
                                  validator: _validateConfirmPass,
                                  keyboardType: TextInputType.text,
                                  controller: _viewModel.confirmPassController,
                                  obscureText: !_viewModel.passwordVisible,
                                  //This will obscure text dynamically
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      size: prefixIconSize(),
                                    ),
                                    labelText: 'Nhập lại mất khẩu',
                                    // Here is key idea
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _viewModel.passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        size: prefixIconSize(),
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _viewModel.passwordVisible =
                                              !_viewModel.passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: _viewModel.enableEdit
                        ? GestureDetector(
                            onTap: () {
                              if (widget.keyCheck == Register.REGISTER)
                                register(context);
                              else {
                                if (widget.keyCheck == Register.ADD_PERSONEL) {
                                  createPersonnel(context);
                                } else {
                                  upDatePersonnels(context);
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              padding: EdgeInsets.only(top: 13, bottom: 13),
                              decoration:
                                  getDecorationInput(color: Colors.blue),
                              child: Text(
                                widget.keyCheck == Register.REGISTER
                                    ? "Đăng ký"
                                    : widget.keyCheck == Register.ADD_PERSONEL
                                        ? "Thêm nhân viên"
                                        : "Sửa tài khoản",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: StreamBuilder(
            stream: _presenter.getStream(RegisterPresenter.LOADING),
            builder: (ctx, snap) => snap.data is BlocLoading
                ? GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: 80,
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/icons/loading.gif",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  )
                : Container(),
          ),
        )
      ],
    );
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
    setState(() {});
  }

  getDecorationInput({color}) {
    if (color != null)
      return BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(3, 3)),
          ]);
    else
      return BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(40)));
  }

  inputStyle() {
    return TextStyle();
  }

  avatar() {
    print(widget.user);
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_viewModel.enableEdit) {
                openImageonCamera();
              }
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
//              padding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(70),
                ),
              ),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _viewModel.avatarImage != null
                      ? _viewModel.avatarImage
                      : widget.keyCheck == Register.DETAIL
                          ? _viewModel.user != null
                              ? _viewModel.user["image"] != ""
                                  ? NetworkImage(
                                      Common.rootUrl + _viewModel.user["image"])
                                  : AssetImage("assets/images/defAvatar.png")
                              : Common.user["image"] != ""
                                  ? NetworkImage(
                                      Common.rootUrl + Common.user["image"])
                                  : AssetImage("assets/images/defAvatar.png")
                          : AssetImage("assets/images/defAvatar.png"),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            margin: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.camera_alt,
            ),
          )
        ],
      ),
    );
  }

  void setImage() {
//    _presenter.setImage((value) {
////      print(value.toString());
////      setState(() {
////        _viewModel.avatarImage = Image.memory(value);
////      });
//    });
  }

  String _validateName(String value) {
    if (value.length > 0) return null;
    return "Nhập thiếu Tên";
  }

  String _validateEmail(String value) {
    if (value.length > 0) if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value))
      return "Email không hợp lệ";
    else
      return null;
    return "Nhập thiếu Email";
  }

  String _validateUsername(String value) {
    if (value.length == 0) return "Nhập thiếu Tên người dùng";
    if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value))
      return "Username chỉ tồn tại a-z,A-Z và 0-9 ";
    if (value.length < 6) return "Tên người dùng phải trên 6 ký tự";
    return null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) return "Nhập thiếu";
    if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value))
      return "Username chỉ tồn tại a-z,A-Z và 0-9 ";
    if (value.length < 6) return "Mật khẩu quá ngắn";
    return null;
  }

  String _validateConfirmPass(String value) {
    if (value.length == 0) return "Nhập thiếu";
    if (value != _viewModel.passwordController.text)
      return "Không khớp với mật khẩu";
    return null;
  }

  void register(BuildContext context) {
    if (_key.currentState.validate()) _presenter.register();
  }

  void openImageonCamera() {
    _presenter.getImage(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _presenter.disposeView();
  }

  @override
  void backView(value) {
    // TODO: implement backView
    if (_viewModel.context != null) {
      Navigator.pop(_viewModel.context, value);
    }
  }

  @override
  void showSnackbar(String mess, String status) {
    // TODO: implement showSnackbar
    _keyS.currentState.showSnackBar(
      new SnackBar(
        content: Text(mess),
        duration: Duration(seconds: 3),
        backgroundColor: status == "w" ? Colors.red : Colors.blue,
      ),
    );
  }

  prefixIconSize() {
    return 17.0;
  }

  void createPersonnel(BuildContext context) {
    if (_key.currentState.validate()) _presenter.createPersonnel();
  }

  void upDatePersonnels(BuildContext context) {
    if (_key.currentState.validate()) _presenter.updateUser();
  }
}
