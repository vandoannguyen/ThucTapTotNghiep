import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BlogEvent.dart';

class Warehouse extends StatelessWidget {
  var data;

  Warehouse(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              "THÔNG TIN KHO",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Card(
              elevation: 4,
              child: data is BlocLoading
                  ? Container(
                      width: Common.widthOfScreen - 20,
                      height: 50,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/loading.gif",
                        width: 30,
                        height: 30,
                      ),
                    )
                  : data is BlocLoaded
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("Số lượng tồn kho"),
                                    ),
                                    Text(
                                      "${data.value["count"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.grey,
                              ),
//                              Container(
//                                padding: EdgeInsets.only(top: 10, bottom: 10),
//                                child: Row(
//                                  children: <Widget>[
//                                    Expanded(
//                                      child: Text("Giá trị tồn kho"),
//                                    ),
//                                    Text(
//                                      "${Common.CURRENCY_FORMAT.format(data.value["total"])} VND",
//                                      style: TextStyle(
//                                          fontWeight: FontWeight.w600,
//                                          fontSize: 18),
//                                    )
//                                  ],
//                                ),
//                              ),
//                              Container(
//                                height: 0.5,
//                                color: Colors.grey,
//                              ),
                            ],
                          ),
                        )
                      : data is BlocFailed
                          ? Container(
                              child: Text(data.mess),
                            )
                          : Container())
        ],
      ),
    );
  }
}
