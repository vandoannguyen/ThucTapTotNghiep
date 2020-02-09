import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/common/CustomButton.dart';
import 'package:init_app/login/Login.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: Common.user["image"] == null ||
                            Common.user["image"] == ""
                        ? AssetImage("assets/images/defAvatar.png")
                        : NetworkImage(Common.rootUrl + Common.user["image"]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Common.user["name"],
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(Common.user["email"])
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: CustomButton(
              onTap: () {
                nhanVien();
              },
              iconLeft: Icons.people,
              colorIconLeft: Colors.blue,
              lable: "Quản lý nhân viên",
              buttonTextStyle: buttonTextStyle(),
            )),
            SizedBox(
              height: 15,
            ),
            Container(
                child: CustomButton(
              iconLeft: Icons.people,
              colorIconLeft: Colors.blue,
              lable: "Thông tin tài khoản",
              buttonTextStyle: buttonTextStyle(),
            )),
            SizedBox(
              height: 15,
            ),
            Container(
                child: CustomButton(
              iconLeft: Icons.store,
              colorIconLeft: Colors.blue,
              lable: "Thông tin cửa hàng",
              buttonTextStyle: buttonTextStyle(),
            )),
            SizedBox(
              height: 15,
            ),
            Container(
                child: CustomButton(
              onTap: () {
                IntentAnimation.intentPushReplacement(
                    context: context,
                    screen: Login(),
                    exitScreen: this,
                    option: IntentAnimationOption.EXIT_LEFT_TO_RIGHT,
                    duration: Duration(milliseconds: 500));
              },
              iconLeft: Icons.store,
              colorIconLeft: Colors.blue,
              lable: "Đổi mật khẩu",
              buttonTextStyle: buttonTextStyle(),
            )),
            SizedBox(
              height: 15,
            ),
            Container(
                child: CustomButton(
              onTap: () {
                IntentAnimation.intentPushReplacement(
                    context: context,
                    screen: Login(),
                    exitScreen: this,
                    option: IntentAnimationOption.EXIT_LEFT_TO_RIGHT,
                    duration: Duration(milliseconds: 500));
              },
              iconLeft: Icons.store,
              colorIconLeft: Colors.blue,
              lable: "Đăng xuất",
              buttonTextStyle: buttonTextStyle(),
            )),
          ],
        ),
      ),
    );
  }

  buttonTextStyle() {
    return TextStyle();
  }

  void nhanVien() {}
}
