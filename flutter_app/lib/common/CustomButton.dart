import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  var onTap;
  String lable;
  IconData iconLeft, iconRight;
  TextStyle buttonTextStyle =
      TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500);
  Color colorIconLeft = Colors.blue, colorIconRight = Colors.grey;

  CustomButton(
      {@required this.onTap,
      @required this.lable,
      @required this.iconLeft,
      @required this.iconRight,
      this.colorIconLeft,
      this.colorIconRight,
      this.buttonTextStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                color: Colors.blue, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: <Widget>[
            Icon(
              iconLeft,
              color: colorIconLeft,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                lable,
                style: buttonTextStyle,
              ),
            ),
            Icon(
              iconRight,
              color: colorIconRight,
            ),
          ],
        ),
      ),
    );
  }
}
