import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

import 'CreateBilllViewmodel.dart';

class TtemMerchandis extends StatefulWidget {
  int index;
  CreateBillViewmodel viewmodel;
  var onPressButton;
  bool enable = true;

  TtemMerchandis(this.index, this.viewmodel, this.onPressButton, {this.enable});

  @override
  _TtemMerchandisState createState() => _TtemMerchandisState();
}

class _TtemMerchandisState extends State<TtemMerchandis> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
//      height: 90,
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            child: widget.viewmodel.listMerchandis[widget.index]["image"] ==
                        null ||
                    widget.viewmodel.listMerchandis[widget.index]["image"] == ""
                ? Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.fill,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.png",
                    image: Common.rootUrl +
                        widget.viewmodel.listMerchandis[widget.index]["image"]),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
              width: Common.widthOfScreen / 3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Text(
                        widget.viewmodel.listMerchandis[widget.index]
                            ["nameMerchandise"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Text(
                        "${widget.viewmodel.listMerchandis[widget.index]["barcode"]}"),
                    Text(
                      "${widget.viewmodel.listMerchandis[widget.index]["outputPrice"] * widget.viewmodel.listMerchandis[widget.index]["countsp"]}",
                    ),
                  ],
                ),
              )),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                widget.enable != null && widget.enable
                    ? IconButton(
                        onPressed: () {
                          pressMinus();
                        },
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          color: Colors.blue,
                        ),
                      )
                    : Container(
                        width: 50,
                      ),
                GestureDetector(
                  child: Container(
                    width: Common.widthOfScreen / 9,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blue,
                            width: 0.5,
                            style: BorderStyle.solid)),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "${widget.viewmodel.listMerchandis[widget.index]["countsp"]}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                widget.enable != null && widget.enable
                    ? IconButton(
                        onPressed: () {
                          pressAdd();
                        },
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.blue,
                        ),
                      )
                    : Container(
                        width: 50,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  void pressMinus() {
    if (widget.viewmodel.listMerchandis[widget.index]["countsp"] > 0) {
      setState(() {
        widget.viewmodel.listMerchandis[widget.index]["countsp"]--;
      });
    }
    widget.onPressButton();
  }

  void pressAdd() {
    setState(() {
      widget.viewmodel.listMerchandis[widget.index]["countsp"]++;
    });
    widget.onPressButton();
  }
}
