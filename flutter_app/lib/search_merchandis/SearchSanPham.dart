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
                  showBarcode();
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
    );
  }

  void showBarcode() async {
    print("dẹksdlkasdasd");
    var barcode = await scan.scan();
    print("barcode ${barcode}");
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }
}
