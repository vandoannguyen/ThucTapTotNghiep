import 'package:flutter/material.dart';

import 'MorePresenter.dart';
import 'MoreViewModel.dart';

class ChangePassDialog extends StatelessWidget {
  MoreViewModel _viewModel;
  MorePresenter _presenter;
  var context;

  ChangePassDialog(this._viewModel, this._presenter, this.context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(
        "Đổi mật khẩu:",
        style: TextStyle(color: Colors.green),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _viewModel.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  onFieldSubmitted: (vall) {
                    _viewModel.fcNewPass.requestFocus();
                  },
                  controller: _viewModel.curentPass,
                  validator: _presenter.validateCurrentPass,
                  style: textFormFeildStyle(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    labelText: "Mật khẩu hiện tại",
                    prefixIcon: Icon(
                      Icons.lock_open,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onFieldSubmitted: (value) {
                    _viewModel.fcConfirm.requestFocus();
                  },
                  focusNode: _viewModel.fcNewPass,
                  controller: _viewModel.newPass,
                  validator: _presenter.validateNewPass,
                  style: textFormFeildStyle(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    labelText: "Mật khẩu mới",
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: _viewModel.fcConfirm,
                  controller: _viewModel.confirmPass,
                  validator: _presenter.validateComfirmPass,
                  style: textFormFeildStyle(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    labelText: "Nhập lại mật khẩu",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.orange,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "HỦY",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
        FlatButton(
          onPressed: () {
            _presenter.changePass(context);
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  textFormFeildStyle() {
    return TextStyle(color: Colors.blue);
  }
}
