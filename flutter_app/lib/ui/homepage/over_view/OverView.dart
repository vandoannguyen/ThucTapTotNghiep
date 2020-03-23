import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

class OverView extends StatefulWidget {
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
    );
  }
}
