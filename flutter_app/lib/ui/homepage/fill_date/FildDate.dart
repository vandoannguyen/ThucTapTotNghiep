import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BlogEvent.dart';

// ignore: must_be_immutable
class FillDate extends StatelessWidget {
  var title, fromDate, toDate;
  var data;
  FillDate(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        width: Common.widthOfScreen - 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Trong khoảng",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: data is BlocLoading
                          ? Text("")
                          : data is BlocLoaded
                              ? Text(
                                  "${Common.DATE_FORMAT(data.value["fristDay"])}   -   ${Common.DATE_FORMAT(data.value["endDay"])}",
                                  style: TextStyle(fontSize: 13),
                                )
                              : Text(""),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.date_range,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }
}
