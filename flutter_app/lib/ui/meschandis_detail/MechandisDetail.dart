import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/meschandis_detail/MerchandisDetailViewModel.dart';
import 'package:init_app/ui/meschandis_detail/MerchandiseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'MerchandisDetailPresenter.dart';

class MerchandiseDetail extends StatefulWidget {
  dynamic check;
  String inputKey;
  var value;
  static final String DETAIL = "detail";
  static final String CREATE = "create";
  static final String API_SUCCESS = "success";

  static final String API_FAILD = "faild";

  MerchandiseDetail({@required inputKey, value}) {
    this.inputKey = inputKey;
    if (inputKey == MerchandiseDetail.DETAIL) {
      this.value = value;
      if (value == null) throw "value of content is null";
    }
  }

  @override
  _MerchandiseDetailState createState() => _MerchandiseDetailState();
}

class _MerchandiseDetailState extends State<MerchandiseDetail>
    implements MerchandiseDetailView {
  MerchandiseDetailPresenter _presenter;
  MerchandiseDetailViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new MerchandiseDetailViewModel();
    _presenter = new MerchandiseDetailPresenter(_viewModel);
    _presenter.getCategory();
    _presenter.intiView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _viewModel.scaffoldKey,
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
        title: Text(widget.inputKey == MerchandiseDetail.DETAIL
            ? "Thông tin hàng"
            : "Thêm hàng"),
        actions: widget.inputKey == MerchandiseDetail.DETAIL
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
                          _viewModel.isEditing ? openImageonCamera() : null;
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                              width: Common.widthOfScreen / 5,
                              padding: EdgeInsets.all(5),
                              height: Common.widthOfScreen / 5,
                              child: widget.inputKey != MerchandiseDetail.DETAIL
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
                      widget.inputKey == MerchandiseDetail.DETAIL
                          ? Container(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _viewModel.isEditing = true;
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
                          readOnly: !_viewModel.isEditing,
                          controller: _viewModel.tenSpControl,
                          style: textStyle(),
                          enabled: _viewModel.isEditing,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Tên sản phẩm"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditing,
                          controller: _viewModel.barcodeControl,
                          style: textStyle(),
                          enabled: _viewModel.isEditing,
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
                          readOnly: !_viewModel.isEditing,
                          controller: _viewModel.descriptionController,
                          style: textStyle(),
                          enabled: _viewModel.isEditing,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true, labelText: "Mô tả"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditing,
                          controller: _viewModel.inputPriceController,
                          style: textStyle(),
                          keyboardType: TextInputType.number,
                          enabled: _viewModel.isEditing,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              alignLabelWithHint: true, labelText: "Giá nhập"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: !_viewModel.isEditing,
                          controller: _viewModel.outputPriceController,
                          keyboardType: TextInputType.number,
                          style: textStyle(),
                          enabled: _viewModel.isEditing,
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
                                  "${_viewModel.selectedCategory["nameCategory"]}",
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
                          readOnly: widget.inputKey == MerchandiseDetail.CREATE
                              ? false
                              : true,
                          controller: _viewModel.totalMerchandiseController,
                          keyboardType: TextInputType.phone,
                          style: textStyle(),
                          enabled: _viewModel.isEditing,
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
                  visible: _viewModel.isEditing,
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          pressOk(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(3, 3))
                              ]),
                          alignment: Alignment.center,
                          height: 40,
                          width: Common.widthOfScreen / 3,
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontSize: 17),
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
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(3, 3))
                              ]),
                          alignment: Alignment.center,
                          height: 40,
                          width: Common.widthOfScreen / 3,
                          child: Text(
                            "Hủy",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17),
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
    if (widget.inputKey == MerchandiseDetail.DETAIL) {
      initData();
    }
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
    _presenter.getAvatar();
  }

  void pressOk(context) {
    if (widget.inputKey == MerchandiseDetail.DETAIL) {
      _presenter.updateMerchandise();
    } else {
      _presenter.createMerchandis(context);
    }
  }

  void pressCancel(context) {
    IntentAnimation.intentBack(context: context);
  }

  void showDialogTheLoai(BuildContext context) async {
    print(_viewModel.categories);
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
                        _viewModel.selectedCategory =
                            _viewModel.categories[index];
                        IntentAnimation.intentBack(context: context);
                      },
                      child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Common.widthOfScreen / 3,
                            alignment: Alignment.center,
                            child: Text(
                              _viewModel.categories[index]["nameCategory"],
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ))),
                  itemCount: _viewModel.categories.length,
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
    _viewModel.isEditing = !(widget.inputKey == MerchandiseDetail.DETAIL);
    if (widget.value != null) {
      _viewModel.value = widget.value;
      print(_viewModel.value);
    }
    print(_viewModel.value);
    if (widget.inputKey == MerchandiseDetail.DETAIL) {
      _viewModel.outputPriceController.text =
          _viewModel.value["outputPrice"].toString();
      _viewModel.inputPriceController.text =
          _viewModel.value["inputPrice"].toString();
      _viewModel.totalMerchandiseController.text =
          _viewModel.value["count"].toString();
      _viewModel.tenSpControl.text = _viewModel.value["nameMerchandise"];
      _viewModel.barcodeControl.text = _viewModel.value["barcode"];
      _viewModel.selectedCategory = _viewModel.categories.firstWhere(
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
                    IntentAnimation.intentBack(context: context, result: "ok");
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(3, 3))
                        ]),
                    alignment: Alignment.center,
                    width: 100,
                    height: 40,
                    child: Text(
                      "Xóa",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    IntentAnimation.intentBack(context: context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(3, 3))
                        ]),
                    alignment: Alignment.center,
                    width: 100,
                    height: 40,
                    child: Text(
                      "Hủy",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ));
    if (result != null && result == "ok") {
      _presenter.deleteMerchandise(_viewModel.value);
    }
  }

  @override
  void showSnackBar({String keyInput, String mess}) {
    // TODO: implement showSnackBar
    _viewModel.scaffoldKey.currentState.showSnackBar(SnackBar(
      elevation: 4,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          keyInput == MerchandiseDetail.API_SUCCESS ? Colors.blue : Colors.red,
      content: Container(
        height: 35,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(mess),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void continueAdd() {
    // TODO: implement continueAdd
    _viewModel = new MerchandiseDetailViewModel();
    setState(() {});
  }
}
