import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/common/CustomButton.dart';
import 'package:init_app/create_bill/CreateBill.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                themHoaDon(context);
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/icon_add_bill.png",
                      fit: BoxFit.fill,
                      height: Common.heightOfScreen / 6,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Thêm hóa đơn",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onTap: () {
                danhSachDonHang(context);
              },
              lable: "Danh sách đơn hàng",
              buttonTextStyle: buttonTextStyle(),
              iconRight: Icons.navigate_next,
              colorIconRight: Colors.grey,
              iconLeft: Icons.cloud_download,
              colorIconLeft: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.trending_up,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "Trong ngày",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            width: 1,
                            color: Colors.blue,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Số lượng",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Text("45")
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            width: 1,
                            color: Colors.blue,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Tổng tiền",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Text("2000000")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                      color: Colors.grey,
                      height: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ItemHoaDon(index),
                        itemCount: 10,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void themHoaDon(BuildContext context) {
    IntentAnimation.intentNomal(
      context: context,
      screen: CreateBill(),
      option: IntentAnimationOption.RIGHT_TO_LEFT,
      duration: Duration(milliseconds: 500),
    );
  }

  buttonTextStyle() {
    return TextStyle(
        color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w600);
  }

  void danhSachDonHang(BuildContext context) {
    print("Danh sách đơn hàng");
  }
}

class ItemHoaDon extends StatelessWidget {
  int index;

  ItemHoaDon(this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "TÊN HÓA ĐƠN",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("15:32 31/1/2019")
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "Thu nhập",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("4500000")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
