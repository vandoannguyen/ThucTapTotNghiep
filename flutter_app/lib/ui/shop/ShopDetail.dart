import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/shop/ShopDetailView.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'ShopDetailPresenter.dart';
import 'ShopDetailViewModel.dart';

class ShopDetail extends StatefulWidget {
  var keyCheck, value;
  static const String DETAIL = "detail";
  static const String CREATE = "create";

  ShopDetail({@required this.keyCheck, this.value}) {
    if (keyCheck == null) throw "keyCheck mush not be null";
    if (keyCheck != CREATE && (value == null || value == {}))
      throw "value mush not be null";
  }

  @override
  _ShopDetailState createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> implements ShopDetailView {
  ShopDetailViewModel _viewModel;
  ShopDetailPresenter _presenter;
  var isDow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new ShopDetailViewModel();
    _presenter = new ShopDetailPresenter(_viewModel);
    _presenter.intiView(this);
    _viewModel.isEditEnable = widget.keyCheck != ShopDetail.DETAIL;
    if (!_viewModel.isEditEnable) {
      print(widget.value);
      _viewModel.shopNameCtrl.text = widget.value["name"];
      _viewModel.addressCtrl.text = widget.value["address"];
      _viewModel.phoneNumberCtrl.text = widget.value["phoneNumber"];
      _viewModel.descriptionCtrl.text = widget.value["description"];
      _viewModel.warningCountEditCtrl.text =
          widget.value["warningCount"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _viewModel.scaffoldKey,
      appBar: AppBar(
        actions: widget.keyCheck == "detail"
            ? <Widget>[
                Common.user["idRole"] == 2
                    ? IconButton(
                        icon: Icon(Icons.mode_edit),
                        onPressed: () {
                          setState(() {
                            _viewModel.isEditEnable = true;
                          });
                        },
                      )
                    : Container()
              ]
            : [],
        title: Text("Cửa hàng"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: Container(
                width: Common.widthOfScreen - 60,
                child: SingleChildScrollView(
                  child: Form(
                    key: _viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            openImageonCamera();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(4, 8),
                                    blurRadius: 4,
                                  )
                                ],
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90))),
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: _viewModel.avatarImage != null
                                  ? _viewModel.avatarImage
                                  : AssetImage("assets/icons/def_store.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          enabled: _viewModel.isEditEnable,
                          controller: _viewModel.shopNameCtrl,
                          validator: _presenter.validator,
                          style: inputTextStyle(),
                          decoration: InputDecoration(
                              labelText: "Tên cửa hàng",
                              prefixIcon: Icon(
                                Icons.store,
                                color: Colors.blue,
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          enabled: _viewModel.isEditEnable,
                          controller: _viewModel.addressCtrl,
                          validator: _presenter.validator,
                          style: inputTextStyle(),
                          decoration: InputDecoration(
                              labelText: "Địa chỉ",
                              prefixIcon: Image.asset(
                                "assets/icons/locator_add.png",
                                width: 25,
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          enabled: _viewModel.isEditEnable,
                          keyboardType: TextInputType.number,
                          controller: _viewModel.phoneNumberCtrl,
                          validator: _presenter.validator,
                          style: inputTextStyle(),
                          decoration: InputDecoration(
                              labelText: "Số điện thoại",
                              prefixIcon: Icon(
                                Icons.phone_in_talk,
                                color: Colors.blue,
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          enabled: _viewModel.isEditEnable,
                          keyboardType: TextInputType.number,
                          controller: _viewModel.warningCountEditCtrl,
                          validator: _presenter.validator,
                          style: inputTextStyle(),
                          decoration: InputDecoration(
                              labelText: "Hạn mức cảnh báo",
                              prefixIcon: Icon(
                                Icons.warning,
                                color: Colors.red,
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _viewModel.descriptionCtrl,
                          style: inputTextStyle(),
                          decoration: InputDecoration(
                              labelText: "Ghi chú",
                              prefixIcon: Icon(
                                Icons.note,
                                color: Colors.blue,
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: _viewModel.isEditEnable,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: Common.widthOfScreen / 3,
                                    alignment: Alignment.center,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5,
                                              offset: Offset(3, 3))
                                        ]),
                                    child: Text("HỦY"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_viewModel.formKey.currentState
                                        .validate()) {
                                      widget.keyCheck == ShopDetail.CREATE
                                          ? _presenter.addShop()
                                          : _presenter.updateShop();
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: Common.widthOfScreen / 3,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        boxShadow: [
                                          isDow
                                              ? BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0))
                                              : BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 5,
                                                  offset: Offset(3, 3))
                                        ]),
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: StreamBuilder(
                stream: _presenter.getStream(ShopDetailPresenter.LOADING),
                builder: (ctx, snap) => snap.data is BlocLoading
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          color: Colors.transparent,
                          child: Image.asset(
                            "assets/icons/loading.gif",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      )
                    : Container(),
              )),
        ],
      ),
    );
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }

  void openImageonCamera() {
    _presenter.getImage(() {
      setState(() {});
    });
  }

  inputTextStyle() {
    return TextStyle();
  }
}
