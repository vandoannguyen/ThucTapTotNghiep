import 'package:flutter/material.dart';
import 'package:init_app/ui/category/CategoryView.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'CategoryPresenter.dart';
import 'CategoryViewModel.dart';

class Category extends StatefulWidget {
  static var API_SUCCESS = "success";

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> implements CategoryView {
  CategoryPresenter _presenter;
  CategoryViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new CategoryViewModel();
    _presenter = new CategoryPresenter(_viewModel);
    _presenter.intiView(this);
    _presenter.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _viewModel.scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Loại mặt hàng"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setCategory(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
          child: StreamBuilder(
        stream: _presenter.getStream(_presenter.LIST_CATEGORY),
        builder: (ctx, snap) => snap.data is BlocLoading
            ? Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/icons/loading.gif",
                  width: 30,
                  height: 30,
                ),
              )
            : snap.data is BlocLoaded
                ? ListView.builder(
                    itemBuilder: (context, index) => itemView(index),
                    itemCount: _viewModel.danhSachLoaiMatHang.length,
                  )
                : snap.data is BlocFailed
                    ? Container(
                        child: Text(snap.data.mess),
                      )
                    : Container(),
      )),
    );
  }

  void setCategory(context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Nhập tên loại mặt hàng"),
              content: TextFormField(
                controller: _viewModel.tenLoaiMatHangContrller,
                decoration: InputDecoration(labelText: "Tên loại mặt hàng"),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    dialogPressOk(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 2),
                              blurRadius: 3)
                        ]),
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
                    child: Text(
                      "OK",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    dialogPressCanncel(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 2),
                              blurRadius: 3)
                        ]),
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
                    child: Text(
                      "HỦY",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ));
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
    setState(() {});
  }

  void dialogPressOk(context) {
    if (_viewModel.tenLoaiMatHangContrller.text != "") {
      _presenter.addCategory(_viewModel.tenLoaiMatHangContrller.text);
    }
    Navigator.pop(context);
  }

  void dialogPressCanncel(context) {
    Navigator.pop(context);
  }

  itemView(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.only(left: 15),
        alignment: Alignment(-1, 0),
        child: Text(_viewModel.danhSachLoaiMatHang[index]["nameCategory"]),
      ),
    );
  }

  @override
  void showSnackBar({@required keyInput, mess}) {
    // TODO: implement showSnackBar
    _viewModel.scaffoldKey.currentState.showSnackBar(SnackBar(
      elevation: 4,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          keyInput == Category.API_SUCCESS ? Colors.blue : Colors.red,
      content: Container(
        child: Text(mess),
      ),
    ));
  }
}
