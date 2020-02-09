import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/homepage/HomePagePresenter.dart';
import 'package:init_app/homepage/HomePageViewModel.dart';
import 'package:init_app/utils/BaseView.dart';

class HomePage extends StatelessWidget implements BaseView {
  HomePageViewModel _viewModel;
  HomePagePresenter _presenter;

  @override
  Widget build(BuildContext context) {
    _viewModel = new HomePageViewModel();
    _presenter = new HomePagePresenter(_viewModel);
    _presenter.intiView(this);
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Container(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Chi nhánh mặc định",
              style: TextStyle(color: Colors.white),
            )
          ],
        )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FilDate(_viewModel,
                    title: "Tuần qua",
                    fromDate: "2/2/2019",
                    toDate: "2/3/2019"),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "TỔNG QUAN",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Card(
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: Common.widthOfScreen / 3.5,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "0",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text("Đơn Nhập"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: Common.widthOfScreen / 3.5,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "0",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text("Tổng lượng nhập"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: Common.widthOfScreen / 3.5,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "0",
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
                            Card(
                              child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: Common.widthOfScreen / 3.5,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "0",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text("Tổng lượng bán"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
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
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "HÀNG BÁN CHẠY",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (ctx, inde) => Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          itemBuilder: (ctx, index) =>
                              ItemView({"item": "item"}),
                          itemCount: 3,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "THÔNG TIN KHO",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text("Số lượng tồn kho"),
                                      ),
                                      Text(
                                        "800",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text("Giá trị tồn kho"),
                                      ),
                                      Text(
                                        "${_viewModel.currencyFormat.format(800000000)} VND",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "HÀNG SẮP HẾT",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Card(
                        elevation: 4,
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (ctx, inde) => Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          itemBuilder: (ctx, index) => ItemView({}),
                          itemCount: 3,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void updateUI(dynamic) {}

  ItemView(var index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/default_image.png",
            height: Common.heightOfScreen / 10,
            width: Common.heightOfScreen / 10,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tên Hàng",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "500",
                  style: TextStyle(
                      color: index == 0
                          ? Colors.red
                          : index == 1 ? Colors.orange : Colors.lightGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilDate extends StatefulWidget {
  var title, fromDate, toDate;
  HomePageViewModel _viewModel;

  @override
  _FilDateState createState() => _FilDateState();

  FilDate(this._viewModel, {this.title, this.fromDate, this.toDate});
}

class _FilDateState extends State<FilDate> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Common.widthOfScreen - 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.fromDate}   -   ${widget.toDate}",
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.date_range,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }
}
