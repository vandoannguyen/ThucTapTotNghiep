import 'package:flutter/material.dart';
import 'package:init_app/ui/create_bill/CreateBill.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'ItemHoaDon.dart';

class ListBill extends StatelessWidget {
  dynamic listData;

  ListBill(this.listData);

  @override
  Widget build(BuildContext context) {
    if (listData == null) listData = [];
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách đơn hàng"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (ctx, index) => GestureDetector(
              child: ItemHoaDon(listData[index]),
              onTap: () {
                detailBill(context, index);
              },
            ),
            itemCount: listData.length,
          ),
        ));
  }

  void detailBill(BuildContext context, index) {
    IntentAnimation.intentNomal(
        context: context,
        screen: CreateBill(
          keyCheck: "detail",
          value: listData[index],
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }
}
