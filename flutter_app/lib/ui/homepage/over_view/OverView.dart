import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/utils/BlogEvent.dart';

class OverView extends StatefulWidget {
  var data;

  OverView(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OverViewState();
  }
}

class OverViewState extends State<OverView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "TỔNG QUAN",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            padding: EdgeInsets.all(10),
          ),
          widget.data is BlocLoading
              ? Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/loading.gif",
                    width: 30,
                    height: 30,
                  ),
                )
              : widget.data is BlocLoaded
                  ? Card(
                      elevation: 4,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ItemOverlay(
                              title: "Đơn nhâp",
                              value: widget.data.value["countBillIn"],
                            ),
                            ItemOverlay(
                              title: "Tổng chi",
                              value: widget.data.value["totalIn"],
                            ),
                            ItemOverlay(
                              title: "Tổng chi thực",
                              value: widget.data.value["totalInReal"],
                            ),
                            ItemOverlay(
                              title: "Đơn bán",
                              value: widget.data.value["countBillOut"],
                            ),
                            ItemOverlay(
                              title: "Tổng thu",
                              value: widget.data.value["totalOut"],
                            ),
                            ItemOverlay(
                              title: "Tổng thu thực",
                              value: widget.data.value["totalOutReal"],
                            )
                          ]),
                    )
                  : Container()
        ],
      ),
    );
  }
}

class ItemOverlay extends StatelessWidget {
  var value, title;

  ItemOverlay({this.value, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("${title} : "),
                Text(
                  "${value}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
