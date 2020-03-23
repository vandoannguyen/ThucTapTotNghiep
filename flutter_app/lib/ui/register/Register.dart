import 'package:flutter/material.dart';

import 'RegisterPresenter.dart';
import 'RegisterView.dart';
import 'RegisterViewModel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements RegisterView {
  RegisterPresenter _presenter;
  RegisterViewModel _viewModel;
  GlobalKey<FormState> _key;

  @override
  void initState() {
    _key = new GlobalKey();
    _viewModel = new RegisterViewModel();
    _presenter = new RegisterPresenter(_viewModel);
    _presenter.intiView(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Đăng ký",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Chào mừng bạn đến với SmartShop",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                    onTap: () {
                      setImage();
                    },
                    child: avatar()),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: getDecorationInput(),
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.perm_contact_calendar),
                            ),
                            Expanded(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  _presenter.nameSummit();
                                },
                                validator: _validateName,
                                style: inputStyle(),
                                controller: _viewModel.fullNameController,
                                decoration: InputDecoration(
                                    labelText: "Họ tên",
                                    border: InputBorder.none,
                                    hintText: "Họ tên"),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: getDecorationInput(),
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.email),
                            ),
                            Expanded(
                              child: TextFormField(
                                focusNode: _viewModel.fcEmail,
                                onFieldSubmitted: (value) {
                                  _presenter.emailSummit();
                                },
                                validator: _validateEmail,
                                style: inputStyle(),
                                controller: _viewModel.emailController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Email",
                                    hintText: "Email"),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: getDecorationInput(),
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.person),
                            ),
                            Expanded(
                              child: TextFormField(
                                focusNode: _viewModel.fcUsername,
                                onFieldSubmitted: (value) {
                                  _presenter.userNameSummit();
                                },
                                validator: _validateUsername,
                                style: inputStyle(),
                                controller: _viewModel.usernameController,
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    border: InputBorder.none,
                                    hintText: "Username"),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: getDecorationInput(),
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.lock),
                            ),
                            Expanded(
                              child: TextFormField(
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
                                  border: InputBorder.none,
                                  labelText: 'Mật khẩu',
                                  hintText: 'Mật khẩu',
                                  // Here is key idea
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _viewModel.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
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
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: getDecorationInput(),
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.lock_outline),
                            ),
                            Expanded(
                              child: TextFormField(
                                focusNode: _viewModel.fcConfirmPass,
                                validator: _validateConfirmPass,
                                keyboardType: TextInputType.text,
                                controller: _viewModel.confirmPassController,
                                obscureText: !_viewModel.passwordVisible,
                                //This will obscure text dynamically
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Nhập lại mất khẩu',
                                  hintText: 'Nhập lại mật khẩu',
                                  // Here is key idea
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _viewModel.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    dangKy(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 50, right: 50),
                    padding: EdgeInsets.all(15),
                    decoration: getDecorationInput(color: Colors.blue),
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bluebackground.png"),
                  fit: BoxFit.fill)),
          padding: EdgeInsets.all(15)),
    );
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }

  getDecorationInput({color}) {
    if (color != null)
      return BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[600],
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(2, 2)),
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
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              openImageonCamera();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(70))),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _viewModel.avatarImage != null
                    ? _viewModel.avatarImage
                    : AssetImage("assets/images/defAvatar.png"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
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
    if (value.length > 0) return null;
    return "Nhập thiếu Username";
  }

  String _validatePassword(String value) {
    if (value.length < 6) return "Mật khẩu quá ngắn";
    return null;
  }

  String _validateConfirmPass(String value) {
    if (value.length < 6) return "Mật khẩu quá ngắn";
    return null;
  }

  void dangKy(BuildContext context) {
    if (_key.currentState.validate()) _presenter.dangKy();
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
}
