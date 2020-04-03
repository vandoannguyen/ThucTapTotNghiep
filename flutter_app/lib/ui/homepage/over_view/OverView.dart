import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/homepage/HomePagePresenter.dart';
import 'package:init_app/ui/homepage/HomePageView.dart';
import 'package:init_app/ui/homepage/HomePageViewModel.dart';

class OverView extends StatefulWidget {
  HomePageViewModel viewModel;
  HomePagePresenter<HomePageView> presenter;

  OverView(this.viewModel, this.presenter);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OverViewState();
  }
}

class OverViewState extends State<OverView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "TỔNG QUAN",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Container(
                    alignment: Alignment.center,
                    height: Common.widthOfScreen / 3.5,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: Common.widthOfScreen / 3.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "${getSoLuongDonNhap()}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("Đơn Nhập"),
                      ],
                    ),
                  ),
                ),
//                Card(
//                  child: Container(
//                    padding: EdgeInsets.only(top: 10, bottom: 10),
//                    width: Common.widthOfScreen / 3.5,
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          "${getTongLuongNhap()}",
//                          style: TextStyle(color: Colors.grey),
//                        ),
//                        Text("Tổng lượng nhập"),
//                      ],
//                    ),
//                  ),
//                ),
                Card(
                  child: Container(
                    height: Common.widthOfScreen / 3.5,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: Common.widthOfScreen / 3.5,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${getTongKhoanChiNhap()}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("Tổng khoản chi"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: Common.widthOfScreen / 3.5,
                    height: Common.widthOfScreen / 3.5,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "0",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("Đơn Bán"),
                      ],
                    ),
                  ),
                ),
//                Card(
//                  child: Container(
//                    padding: EdgeInsets.only(top: 10, bottom: 10),
//                    width: Common.widthOfScreen / 3.5,
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          "0",
//                          style: TextStyle(color: Colors.grey),
//                        ),
//                        Text("Tổng lượng bán"),
//                      ],
//                    ),
//                  ),
//                ),
                Card(
                  child: Container(
                    height: Common.widthOfScreen / 3.5,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: Common.widthOfScreen / 3.5,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "0",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("Tổng giá trị"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  int getTongLuongNhap() {}

  int getTongKhoanChiNhap() {}

  int getSoLuongDonNhap() {
    int t = 0;
    int totalBillIn = 0;
    int totalEarn = 0;
//    if (widget.viewModel.bills.map((element) {
//      if (element["status"] == 0){
//        t++;
//        totalBillIn+=element[""]
//      }
//        return true;
//    }))
  }
}

class ItemOverlay extends StatefulWidget {
  var value, title;

  ItemOverlay(this.value, this.title);

  @override
  _ItemOverlayState createState() => _ItemOverlayState();
}

class _ItemOverlayState extends State<ItemOverlay> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        alignment: Alignment.center,
        height: Common.widthOfScreen / 3.5,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: Common.widthOfScreen / 3.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${widget.value}",
              style: TextStyle(color: Colors.grey),
            ),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}
