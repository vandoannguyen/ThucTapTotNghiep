import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/create_bill/CreateBill.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:intl/intl.dart';

class ItemHoaDon extends StatelessWidget {
  dynamic itemValue;

  ItemHoaDon(this.itemValue);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: GestureDetector(
        onTap: () {
          IntentAnimation.intentNomal(
              context: context,
              screen: CreateBill(
                keyCheck: CreateBill.KEY_CHECK_DETAIL,
                value: itemValue,
              ),
              option: IntentAnimationOption.RIGHT_TO_LEFT,
              duration: Duration(seconds: 1));
        },
        child: Container(
          color: Colors.transparent,
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
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "${itemValue["name"]}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Container(
                                child: Icon(
                                  Icons.navigate_next,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
//                              "${itemValue["name"]}",
                              getNameSeller(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${DateFormat('dd/MM/yyy HH:mm').format(DateTime.parse(itemValue["dateCreate"]))}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/icons/ic_price.png",
                                          width: 17,
                                          height: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${Common.CURRENCY_FORMAT.format(itemValue["totalPrice"])} vnd",
                                          style: moneyTextStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/icons/ic_discount.png",
                                          width: 17,
                                          height: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${Common.CURRENCY_FORMAT.format(itemValue["discount"])} vnd",
                                          style: moneyTextStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  moneyTextStyle() {
    return TextStyle(color: Colors.grey, fontSize: 12);
  }

  String getNameSeller() {
//    idPersonnel
    var personnel = Common.personnels.firstWhere((element) {
      return element["idPersonnel"] == itemValue["idSeller"];
    }, orElse: () {
      return null;
    });
    return personnel == null
        ? itemValue["idSeller"] == Common.user["idUser"]
            ? Common.user["name"]
            : ""
        : personnel["name"];
  }
}
