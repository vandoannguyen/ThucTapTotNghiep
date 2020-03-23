import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

class ItemHoaDon extends StatelessWidget {
  dynamic itemValue;

  ItemHoaDon(this.itemValue);

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
    );
  }
}
