import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/homepage/HomePageViewModel.dart';

// ignore: must_be_immutable
class MerchandiseStatus extends StatefulWidget {
  HomePageViewModel _homePageViewModel;
  static final String INFOR = "infor";
  static final String WARNING = "warning";
  String keyCheck = "";

  MerchandiseStatus(this._homePageViewModel, this.keyCheck);

  @override
  _MerchandiseStatusState createState() => _MerchandiseStatusState();
}

class _MerchandiseStatusState extends State<MerchandiseStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.keyCheck == MerchandiseStatus.WARNING
                  ? "HÀNG SẮP HẾT"
                  : "HÀNG BÁN CHẠY",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Card(
            elevation: 4,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (ctx, inde) => Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 0.5,
                color: Colors.grey,
              ),
              itemBuilder: (ctx, index) => ItemView(
                  keyCheck: MerchandiseStatus.WARNING,
                  value: widget.keyCheck == MerchandiseStatus.WARNING
                      ? widget._homePageViewModel.marchandiseWillEmpty[index]
                      : widget._homePageViewModel.bestSellers[index]),
              itemCount: widget.keyCheck == MerchandiseStatus.WARNING
                  ? widget._homePageViewModel.marchandiseWillEmpty.length
                  : widget._homePageViewModel.bestSellers.length,
            ),
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
          value["image"] != null && value["image"] != ""
              ? FadeInImage.assetNetwork(
                  placeholder: "assets/images/default_image.png",
                  image: "${Common.rootUrl}${value["image"]}",
                  height: Common.heightOfScreen / 10,
                  width: Common.heightOfScreen / 10,
                )
              : Image.asset(
                  "assets/images/default_image.png",
                  height: Common.heightOfScreen / 10,
                  width: Common.heightOfScreen / 10,
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
                            color: value["countsp"] == 0
                                ? Colors.red
                                : value["countsp"] == 1
                                    ? Colors.orange
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
