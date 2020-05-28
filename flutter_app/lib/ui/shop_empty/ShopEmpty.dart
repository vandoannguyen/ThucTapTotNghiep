import 'package:flutter/material.dart';
import 'package:init_app/ui/shop/ShopDetail.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class ShopEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.only(top: 30),
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black54,
                    size: 17,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 200,
              height: 200,
              child: Card(
                color: Colors.blue[100],
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset("assets/images/smartShop.png"),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: () {
                IntentAnimation.intentPushReplacement(
                    context: context,
                    screen: ShopDetail(keyCheck: ShopDetail.CREATE),
                    option: IntentAnimationOption.RIGHT_TO_LEFT,
                    duration: Duration(milliseconds: 800));
              },
              child: Container(
                  child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                color: Colors.blue,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  height: 40,
                  child: Text(
                    "Tạo cửa hàng",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Bạn chưa có cửa hàng vui lòng tạo cửa hàng",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w400),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
