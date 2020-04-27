import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';

class MerchandiseStatusMore extends StatelessWidget {
  static const String WARNING = "WARNING";
  static const String INFOR = "INFOR";
  String keyCheck;
  dynamic value;

  MerchandiseStatusMore({this.keyCheck, this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(keyCheck == INFOR
            ? "Top 10 hàng bán chạy"
            : "Danh sách hàng sắp hết"),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) => merchandisItem(context, index),
          itemCount: value.length,
        ),
      ),
    );
  }

  merchandisItem(context, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Container(
        height: 90,
        color: Colors.transparent,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 7, offset: Offset(4, 4))
                ],
              ),
              child: value[index]["image"] != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                        image: Common.rootUrl + value[index]["image"],
                        placeholder: "assets/images/default_image.png",
                        fit: BoxFit.cover,
                        height: Common.heightOfScreen / 10,
                        width: Common.heightOfScreen / 10,
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/default_image.png",
                        height: Common.heightOfScreen / 10,
                        width: Common.heightOfScreen / 10,
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "${value[index]["nameMerchandise"]}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          keyCheck == INFOR
                              ? "Số lượng bán: "
                              : "Số lượng còn: ",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          "${value[index]["countsp"]}",
                          style: TextStyle(
                              fontSize: 11,
                              color:
                                  keyCheck == INFOR ? Colors.blue : Colors.red),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/icons/in_price.png",
                                width: 15,
                                height: 15,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                "${Common.CURRENCY_FORMAT.format(value[index]["inputPrice"])} VND",
                                style: textItemPriceMerchandise(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "assets/icons/out_price.png",
                                width: 15,
                                height: 15,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                "${Common.CURRENCY_FORMAT.format(value[index]["outputPrice"])} VND",
                                style: textItemPriceMerchandise(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  textItemPriceMerchandise() {
    return TextStyle(fontSize: 11, color: Colors.black45);
  }
}
