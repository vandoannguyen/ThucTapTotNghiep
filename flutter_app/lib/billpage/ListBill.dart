import 'package:flutter/material.dart';
import 'package:init_app/create_bill/CreateBill.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'ItemHoaDon.dart';

class ListBill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách đơn hàng"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (ctx, index) => GestureDetector(
              child: ItemHoaDon(index),
              onTap: () {
                detailBill(context);
              },
            ),
            itemCount: 10,
          ),
        ));
  }

  void detailBill(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: CreateBill(
          keyCheck: "detail",
          value: {
            "listMer": [
              {
                'idMerchandiseDetail': 1,
                'barcode': '132456789',
                'image': '',
                'idShop': 1,
                'nameMerchandise': 'demo ten sp',
                'idCategory': 1,
                'inputPrice': 123,
                'outputPrice': 123,
                'count': 11,
                'unit': '',
                'countsp': 8
              }
            ],
            'name': 'OUT1580912482985',
            'status': 0,
            'idSeller': 10,
            'dateCreate': 1580912482985,
            'discount': 0,
            'idShop': 1,
            'totalPrice': 984,
            'description': 'gxktxixkyxtixi\nwff\nwfwf\nege\ng'
          },
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }
}
