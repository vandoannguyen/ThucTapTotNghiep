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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            width: 50,
            height: 50,
            child: Icon(
              Icons.arrow_back_ios,
              size: 17,
            ),
          ),
        ),
        centerTitle: true,
        title: Text("Loại mặt hàng"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setCategory(context, "", "add");
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
                    itemBuilder: (context, index) => GestureDetector(
                      onLongPress: () {
                        if (index !=
                            _viewModel.danhSachLoaiMatHang.length - 1) {
                          showDialogDelete(context, index);
                        } else {
                          showSnackBar(
                              keyInput: "err",
                              mess: "Không thể xóa loại mặt hàng này!");
                        }
                      },
                      onTap: () {
                        if (index !=
                            _viewModel.danhSachLoaiMatHang.length - 1) {
                          setCategory(
                              context,
                              _viewModel.danhSachLoaiMatHang[index]
                                  ["nameCategory"],
                              "update",
                              idCategory: _viewModel.danhSachLoaiMatHang[index]
                                  ["idCategory"]);
                        } else {
                          showSnackBar(
                              keyInput: "err",
                              mess: "Không thể sửa loại mặt hàng này!");
                        }
                      },
                      child: itemView(index),
                    ),
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

  void setCategory(context, name, key, {idCategory}) {
    print("00000000000000000000000000000");
    if (name != "") {
      _viewModel.tenLoaiMatHangContrller.text = name;
    }
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
                    dialogPressOk(context, key, idCategory: idCategory);
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

  void dialogPressOk(context, key, {idCategory}) {
    if (_viewModel.tenLoaiMatHangContrller.text != "") {
      if (key == "add") {
        _presenter.addCategory(_viewModel.tenLoaiMatHangContrller.text);
      }
      if (key == "update") {
        if (idCategory == null) throw ("idCategory not null");
        print("update");
        _presenter.update(idCategory, _viewModel.tenLoaiMatHangContrller.text);
      }
    }
    _viewModel.tenLoaiMatHangContrller.text = "";
    Navigator.pop(context);
  }

  void dialogPressCanncel(context) {
    _viewModel.tenLoaiMatHangContrller.text = "";
    Navigator.pop(context);
  }

  itemView(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        color: Colors.transparent,
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

  void showDialogDelete(BuildContext context, int index) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text("Bạn có muốn xóa loại mặt hàng này?"),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.red,
                    child: Container(
                      width: 90,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(
                        "Có",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    child: Container(
                      width: 90,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(
                        "Không",
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ));
    if (result) {
      _presenter.deldeteCategory(
          _viewModel.danhSachLoaiMatHang[index]["idCategory"],
          _viewModel.danhSachLoaiMatHang[
              _viewModel.danhSachLoaiMatHang.length - 1]["idCategory"]);
    }
  }
}
