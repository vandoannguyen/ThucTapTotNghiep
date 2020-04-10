import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/create_bill/CreateBill.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class ItemHoaDon extends StatelessWidget {
  dynamic itemValue;

  ItemHoaDon(this.itemValue);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          IntentAnimation.intentNomal(
              context: context,
              screen: CreateBill(
                keyCheck: CreateBill.KEY_CHECK_DETAIL,
                value: itemValue,
              ),
              option: IntentAnimationOption.RIGHT_TO_LEFT,
              duration: Duration(seconds: 1));
        },
        child: Container(
          color: Colors.transparent,
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
                        "${itemValue["name"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "${DateTime.parse(itemValue["dateCreate"]).toLocal().toString().substring(0, 19)}")
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
                    Text(
                        "${Common.CURRENCY_FORMAT.format(itemValue["totalPrice"] - itemValue["discount"])}")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
