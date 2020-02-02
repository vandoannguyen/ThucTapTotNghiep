import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/common/CustomButton.dart';
import 'package:init_app/list_merchandis/ListMerchandis.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class MerchandisPage extends StatefulWidget {
  @override
  _MerchandisPageState createState() => _MerchandisPageState();
}

class _MerchandisPageState extends State<MerchandisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Text("Sản Phẩm"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                themSanPham(context);
              },
              child: Container(
                color: Colors.transparent,
                width: Common.widthOfScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Image.asset(
                        "assets/icons/add_merchandis.png",
                        height: Common.heightOfScreen / 5,
                      ),
                    ),
                    Text(
                      "Thêm sản phẩm",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left,
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
                nhapHang(context);
              },
              lable: "Nhập hàng",
              buttonTextStyle: buttonTextStyle(),
              iconRight: Icons.navigate_next,
              colorIconRight: Colors.grey,
              iconLeft: Icons.cloud_download,
              colorIconLeft: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onTap: () {
                danhSachSanPham(context);
              },
              lable: "Danh sách sản phẩm",
              buttonTextStyle: buttonTextStyle(),
              iconRight: Icons.navigate_next,
              colorIconRight: Colors.grey,
              iconLeft: Icons.featured_play_list,
              colorIconLeft: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  buttonTextStyle() {
    return TextStyle(
        color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w600);
  }

  void themSanPham(BuildContext context) {}

  void nhapHang(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image.path);
//    IntentAnimation.intentNomal(
//        context: context,
//        screen: CameraApp(),
//        option: IntentAnimationOption.RIGHT_TO_LEFT,
//        duration: Duration(milliseconds: 500));
  }

  void danhSachSanPham(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: ListMerchandis(),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }
}
