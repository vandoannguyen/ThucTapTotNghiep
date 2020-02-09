import 'package:flutter/material.dart';

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
