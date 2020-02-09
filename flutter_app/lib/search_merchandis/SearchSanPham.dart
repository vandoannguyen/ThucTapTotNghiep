import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'SearchSanPhamPresenter.dart';
import 'SearchSanPhamViewModel.dart';

class SearchSanPhamScreen extends StatefulWidget {
  @override
  _SearchSanPhamScreenState createState() => _SearchSanPhamScreenState();
}

class _SearchSanPhamScreenState extends State<SearchSanPhamScreen>
    implements BaseView {
  SearchSanPhamPresenter _presenter;
  SearchSanPhamViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = new SearchSanPhamViewModel();
    _presenter = new SearchSanPhamPresenter(_viewModel);
    _presenter.intiView(this);
    _presenter.getListSanPham(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            IntentAnimation.intentBack(context: context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 17,
            color: Colors.grey[700],
          ),
        ),
        title: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[300],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: Common.widthOfScreen - 150,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                      padding: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      width: Common.widthOfScreen - 200,
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration.collapsed(
                          hintText: "Nhập tên tìm kiếm",
                          hintStyle: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showBarcode(context);
                },
                child: Container(
                  child: Icon(
                    Icons.flip,
                    color: Colors.grey[700],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, index) => itemMerchandis(context, index),
          physics: ScrollPhysics(),
          itemCount: _viewModel.listSanPham.length,
        ),
      ),
    );
  }

  void showBarcode(context) async {
    var barcode = await scan.scan();
    var selectMacherdis = _viewModel.listSanPham.firstWhere((element) {
      return element["barcode"] == barcode ? element : null;
    });
    if (selectMacherdis != null) {
      print(selectMacherdis);
      IntentAnimation.intentBack(context: context, result: selectMacherdis);
    }
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
    setState(() {});
  }

  itemMerchandis(context, int index) {
    return GestureDetector(
      onTap: () {
        IntentAnimation.intentBack(
            context: context, result: _viewModel.listSanPham[index]);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Container(
                height: Common.widthOfScreen / 7,
                width: Common.widthOfScreen / 7,
                child: _viewModel.listSanPham[index]["image"] == null ||
                        _viewModel.listSanPham[index]["image"] == ""
                    ? Image.asset(
                        'assets/images/default_image.png',
                        fit: BoxFit.fill,
                      )
                    : FadeInImage.assetNetwork(
                        placeholder: "assets/images/default_image.png",
                        image: Common.rootUrl +
                            _viewModel.listSanPham[index]["image"]),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: Common.widthOfScreen / 7,
                  width: Common.widthOfScreen / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _viewModel.listSanPham[index]["nameMerchandise"],
                        style: topValueStyle(),
                      ),
                      Text(
                        "Barcode: " +
                            _viewModel.listSanPham[index]["barcode"].toString(),
                        style: bottomValueStyle(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: Common.widthOfScreen / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      _viewModel.listSanPham[index]["count"].toString(),
                      style: topValueStyle(),
                    ),
                    Text(
                      "${_viewModel.listSanPham[index]["count"] * _viewModel.listSanPham[index]["outputPrice"]}",
                      style: bottomValueStyle(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  topValueStyle() {
    return TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  }

  bottomValueStyle() {
    return TextStyle(fontSize: 14, color: Colors.grey);
  }
}
