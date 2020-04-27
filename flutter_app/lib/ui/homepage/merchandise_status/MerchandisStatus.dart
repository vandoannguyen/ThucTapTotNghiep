import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/merchandise_status_more/MerchandiseStatusMore.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';

// ignore: must_be_immutable
class MerchandiseStatus extends StatelessWidget {
  dynamic data;
  static final String INFOR = "infor";
  static final String WARNING = "warning";
  String keyCheck = "";

  MerchandiseStatus(this.data, this.keyCheck);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Text(
                    keyCheck == MerchandiseStatus.WARNING
                        ? "HÀNG SẮP HẾT"
                        : "HÀNG BÁN CHẠY",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    onPressed: () {
                      if (keyCheck == INFOR) {
                        IntentAnimation.intentNomal(
                            context: context,
                            screen: MerchandiseStatusMore(
                                keyCheck: MerchandiseStatusMore.INFOR,
                                value: data.value),
                            option: IntentAnimationOption.RIGHT_TO_LEFT,
                            duration: Duration(milliseconds: 500));
                      }
                      if (keyCheck == WARNING) {
                        IntentAnimation.intentNomal(
                            context: context,
                            screen: MerchandiseStatusMore(
                                keyCheck: MerchandiseStatusMore.WARNING,
                                value: data.value),
                            option: IntentAnimationOption.RIGHT_TO_LEFT,
                            duration: Duration(milliseconds: 500));
                      }
                    },
                    icon: Icon(Icons.more_vert),
                  )
                ],
              )),
          Card(
            elevation: 4,
            child: data is BlocLoading
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Image.asset(
                      "assets/icons/loading.gif",
                      height: 30,
                      width: 30,
                    ),
                  )
                : data is BlocLoaded
                    ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (ctx, inde) => Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 0.5,
                              color: Colors.grey,
                            ),
                        itemBuilder: (ctx, index) => ItemView(
                            keyCheck: keyCheck, value: data.value[index]),
                        itemCount:
                            data.value.length < 3 ? data.value.length : 3)
                    : data is BlocFailed
                        ? Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(data.mess),
                          )
                        : Container(),
          )
        ],
      ),
    );
  }

  ItemView({keyCheck, value}) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            clipBehavior: Clip.antiAlias,
            child: value["image"] != null && value["image"] != ""
                ? FadeInImage.assetNetwork(
                    placeholder: "assets/images/default_image.png",
                    image: "${Common.rootUrl}${value["image"]}",
                    height: Common.heightOfScreen / 10,
                    width: Common.heightOfScreen / 10,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    "assets/images/default_image.png",
                    height: Common.heightOfScreen / 10,
                    width: Common.heightOfScreen / 10,
                    fit: BoxFit.fill,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${value["nameMerchandise"]}",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(keyCheck == MerchandiseStatus.INFOR
                          ? "Số lượng bán: "
                          : "Sô lượng tồn: "),
                      Text(
                        "${value["countsp"]}",
                        style: TextStyle(
                            color: keyCheck == MerchandiseStatus.WARNING
                                ? Colors.red
                                : Colors.lightGreen,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
