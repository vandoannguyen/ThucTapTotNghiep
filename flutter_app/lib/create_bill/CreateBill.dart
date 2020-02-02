import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/search_merchandis/SearchSanPham.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

class CreateBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
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
              GestureDetector(
                onTap: () {
                  searchSanPham(context);
                },
                child: Container(
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
                        child: Text(
                          "Nhập tên tìm kiếm",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
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
      body: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              showBarcode();
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 100,
              color: Colors.blue,
              child: Text("Barcode"),
            ),
          )),
    );
  }

  void showBarcode() async {
    print("dẹksdlkasdasd");
    var barcode = await scan.scan();
    print("barcode ${barcode}");
  }

  void searchSanPham(context) async {
    var sp = await IntentAnimation.intentNomal(
      context: context,
      screen: SearchSanPhamScreen(),
      option: IntentAnimationOption.RIGHT_TO_LEFT,
      duration: Duration(milliseconds: 500),
    );
  }
}
