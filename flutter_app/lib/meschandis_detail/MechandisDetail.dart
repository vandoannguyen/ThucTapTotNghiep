import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/meschandis_detail/MerchandisDetailViewModel.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'MerchandisDetailPresenter.dart';

class MerchandisDetail extends StatefulWidget {
  dynamic check;
  String inputKey;
  var value;

  MerchandisDetail({@required inputKey, value}) {
    this.inputKey = inputKey;
    if (inputKey == "detail") {
      this.value = value;
      if (value == null) throw "value of content is null";
    }
  }

  @override
  _MerchandisDetailState createState() => _MerchandisDetailState();
}

class _MerchandisDetailState extends State<MerchandisDetail>
    implements BaseView {
  MerchandisDetailPresenter _presenter;
  MerchandisDetailViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new MerchandisDetailViewModel();
    _presenter = new MerchandisDetailPresenter(_viewModel);
    _presenter.getCategory(() {
      setState(() {});
      _viewModel.selectedCategoty = _viewModel.categiroes[0];
      initData();
    });
    _presenter.intiView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.grey[800],
          ),
          onPressed: () {
            IntentAnimation.intentBack(context: context);
          },
        ),
        title:
            Text(widget.inputKey == "detail" ? "Thông tin hàng" : "Thêm hàng"),
        actions: widget.inputKey == "detail"
            ? [
                IconButton(
                  onPressed: () {
                    deteteSp();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ]
            : [],
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[200],
          height: Common.heightOfScreen,
          width: Common.widthOfScreen,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          openImageonCamera();
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                              width: Common.widthOfScreen / 5,
                              padding: EdgeInsets.all(5),
                              height: Common.widthOfScreen / 5,
                              child: widget.inputKey != "detail"
                                  ? _viewModel.avatarImage != null
                                      ? Image.file(
                                          _viewModel.avatarImage.file,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          "assets/images/default_image.png",
                                          fit: BoxFit.fill,
                                        )
                                  : _viewModel.value["image"] != ""
                                      ? FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/images/default_image.png",
                                          image: _viewModel.value != null
                                              ? "${Common.rootUrl}${_viewModel.value["image"]}"
                                              : "assets/images/default_image.png")
                                      : Image.asset(
                                          "assets/images/default_image.png",
                                          fit: BoxFit.fill,
                                        )),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      widget.inputKey == "detail"
                          ? Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _viewModel.isEditting = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey[700],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _viewModel.formKey,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          readOnly: !_viewModel.isEditting,
                          controller: _viewModel.tenSpControl,
                          style: textStyle(),
                          enabled: _viewModel.isEditting,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Tên sản phẩm"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditting,
                          controller: _viewModel.barcodeControl,
                          style: textStyle(),
                          enabled: _viewModel.isEditting,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Barcode",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  showBarcode();
                                },
                                child: Image.asset(
                                  "assets/icons/barcode.png",
                                  width: 50,
                                  height: 50,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditting,
                          controller: _viewModel.motaController,
                          style: textStyle(),
                          enabled: _viewModel.isEditting,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true, labelText: "Mô tả"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditting,
                          controller: _viewModel.giaNhapController,
                          style: textStyle(),
                          keyboardType: TextInputType.number,
                          enabled: _viewModel.isEditting,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true, labelText: "Giá nhập"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditting,
                          controller: _viewModel.giaBanController,
                          keyboardType: TextInputType.number,
                          style: textStyle(),
                          enabled: _viewModel.isEditting,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true, labelText: "Giá bán"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialogTheLoai(context);
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 10, bottom: 10, right: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Thể loại",
                                  style: textStyle(),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  "${_viewModel.selectedCategoty["nameCategory"]}",
                                  style: textStyle(),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditting,
                          controller: _viewModel.soLuongTrongKhoController,
                          keyboardType: TextInputType.phone,
                          style: textStyle(),
                          enabled: _viewModel.isEditting,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Số lượng trong kho"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _viewModel.isEditting,
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          pressOk();
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 4,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: Common.widthOfScreen / 3,
                            color: Colors.blue,
                            child: Text(
                              "Ok",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          pressCancel(context);
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: Common.widthOfScreen / 3,
                            child: Text(
                              "Hủy",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
    );
  }

  @override
  void updateUI(dynamic) {
//    Future f =
    setState(() {});
    // TODO: implement updateUI
  }

  textStyle() {
    return TextStyle(fontSize: 17);
  }

  void showBarcode() async {
    _presenter.showBarcode();
  }

  void openImageonCamera() {
    _presenter.getAvatar(() {
      setState(() {});
    });
  }

  void pressOk() {
    if (widget.inputKey == "detail") {
      _presenter.updateMerchandis();
    } else {
      _presenter.createMerchandis();
    }
  }

  void pressCancel(context) {
    IntentAnimation.intentBack(context: context);
  }

  void showDialogTheLoai(BuildContext context) async {
    print(_viewModel.categiroes);
    await showDialog(
        context: context,
        builder: (contex) => AlertDialog(
              title: Text("Loại hàng:"),
              content: Container(
                height: Common.heightOfScreen / 4,
                width: Common.widthOfScreen / 3,
                child: ListView.builder(
                  itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        _viewModel.selectedCategoty =
                            _viewModel.categiroes[index];
                        IntentAnimation.intentBack(context: context);
                      },
                      child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Common.widthOfScreen / 3,
                            alignment: Alignment.center,
                            child: Text(
                              _viewModel.categiroes[index]["nameCategory"],
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ))),
                  itemCount: _viewModel.categiroes.length,
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    IntentAnimation.intentBack(context: context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Đóng",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ));
    setState(() {});
  }

  void initData() {
    print("1234567890");
    _viewModel.isEditting = !(widget.inputKey == "detail");
    if (widget.value != null) {
      _viewModel.value = widget.value;
      print(_viewModel.value);
    }
    print(_viewModel.value);
    if (widget.inputKey == "detail") {
      _viewModel.giaBanController.text =
          _viewModel.value["outputPrice"].toString();
      _viewModel.giaNhapController.text =
          _viewModel.value["inputPrice"].toString();
      _viewModel.soLuongTrongKhoController.text =
          _viewModel.value["count"].toString();
      _viewModel.tenSpControl.text = _viewModel.value["nameMerchandise"];
      _viewModel.barcodeControl.text = _viewModel.value["barcode"];
      _viewModel.selectedCategoty = _viewModel.categiroes.firstWhere(
          (element) => element["idCategory"] == _viewModel.value["idCategory"],
          orElse: () => null);
    }
    setState(() {});
  }

  void deleteMerchandis() {}

  void deteteSp() async {
    var result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Xóa sản phẩm này ?"),
              actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      IntentAnimation.intentBack(
                          context: context, result: "ok");
                    },
                    child: Card(
                      elevation: 4,
                      color: Colors.red,
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        child: Text(
                          "Xóa",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      IntentAnimation.intentBack(context: context);
                    },
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        child: Text(
                          "Hủy",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    )),
              ],
            ));
    if (result != null && result == "ok") {
      _presenter.deteteSp(_viewModel.value);
    }
  }
}
