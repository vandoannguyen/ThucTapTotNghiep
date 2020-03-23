import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

class Personnel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhân viên"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, index) => itemNhanVien(index),
          itemCount: 10,
        ),
      ),
    );
  }

  itemNhanVien(int index) {
    return Card(
      elevation: 4,
      child: Container(
        width: Common.widthOfScreen - 50,
        height: 100,
      ),
    );
  }
}
