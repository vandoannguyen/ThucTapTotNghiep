import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:init_app/common/Common.dart';

import 'CreateBill.dart';
import 'CreateBilllViewmodel.dart';

class ItemMerchandis extends StatefulWidget {
  int index;
  CreateBillViewmodel viewmodel;
  var onPressButton;
  bool enable = true;
  var sl = 0;

  ItemMerchandis(this.index, this.viewmodel, this.onPressButton, {this.enable});

  @override
  _ItemMerchandisState createState() => _ItemMerchandisState();
}

class _ItemMerchandisState extends State<ItemMerchandis> {
  int value = 0;

  TextEditingController textInputCountSp;
  GlobalKey<ScaffoldState> scaff;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scaff = new GlobalKey();
    textInputCountSp = new TextEditingController();
  }

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
                    placeholder: "assets/images/default_image.png",
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
                          pressMinus(context);
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
                  onTap: () {
                    showDialogCount(context);
                  },
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
                          pressAdd(context);
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

  void pressMinus(context) {
    if (widget.viewmodel.listMerchandis[widget.index]["countsp"] > 0) {
      setState(() {
        widget.viewmodel.listMerchandis[widget.index]["countsp"]--;
      });
      widget.onPressButton();
    } else {
      showAlertTypeOverload(context, "Không nhập số âm");
    }
  }

  void pressAdd(context) {
    setState(() {
      if (widget.viewmodel.keyCheck ==
          CreateBill.KEY_CHECK_EXPORT_MERCHANDISE) {
        if (widget.viewmodel.listMerchandis[widget.index]["countsp"] >
            widget.viewmodel.listMerchandis[widget.index]["count"]) {
          showAlertTypeOverload(context, "Quá số lượng trong kho");
        } else {
          widget.viewmodel.listMerchandis[widget.index]["countsp"]++;
        }
      } else {
        widget.viewmodel.listMerchandis[widget.index]["countsp"]++;
      }
    });
    widget.onPressButton();
  }

  void showDialogCount(context) {
    showDialog<int>(
        context: context,
        builder: (ctx) => AlertDialog(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Nhập số lượng:",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextField(
                    controller: textInputCountSp,
                    onChanged: (value) {
                      widget.sl = value as int;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: widget.viewmodel.keyCheck ==
                                CreateBill.KEY_CHECK_EXPORT_MERCHANDISE
                            ? "Số lượng bán:"
                            : "Số lượng nhập:"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              if (widget.viewmodel.listMerchandis[widget.index]
                                          ["count"] <
                                      (int.parse(textInputCountSp.text)) &&
                                  widget.viewmodel.keyCheck ==
                                      CreateBill.KEY_CHECK_EXPORT_MERCHANDISE) {
                                showAlertTypeOverload(
                                    context, "Nhập quá số lượng trong kho");
                              } else {
                                widget.viewmodel.listMerchandis[widget.index]
                                        ["countsp"] =
                                    (int.parse(textInputCountSp.text));
                                widget.onPressButton();
                              }
                              textInputCountSp.text = "";
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      offset: Offset(3, 3))
                                ]),
                            alignment: Alignment.center,
                            width: 80,
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            child: Text(
                              "Ok",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      offset: Offset(3, 3))
                                ]),
                            alignment: Alignment.center,
                            width: 80,
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 15),
                            child: Text(
                              "Hủy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  void showAlertTypeOverload(context, mess) {
    widget.viewmodel.scaffoldKey.currentState.showSnackBar(new SnackBar(
        elevation: 4,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Container(
          child: Text(
            mess,
            style: TextStyle(color: Colors.white),
          ),
        )));
  }
}
