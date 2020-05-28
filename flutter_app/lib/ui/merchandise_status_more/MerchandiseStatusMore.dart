import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';

class MerchandiseStatusMore extends StatefulWidget {
  static const String WARNING = "WARNING";
  static const String INFOR = "INFOR";
  String keyCheck;
  dynamic value;

  MerchandiseStatusMore({this.keyCheck, this.value});

  @override
  _MerchandiseStatusMoreState createState() => _MerchandiseStatusMoreState();
}

class _MerchandiseStatusMoreState extends State<MerchandiseStatusMore> {
  AppDataHelper appDataHelper = new AppDataHelper();
  bool isLoading = false;
  GlobalKey<ScaffoldState> scafolldKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scafolldKey = new GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolldKey,
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(widget.keyCheck == MerchandiseStatusMore.INFOR
            ? "Top 10 hàng bán chạy"
            : "Danh sách hàng sắp hết"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () {
                    if (widget.keyCheck == MerchandiseStatusMore.WARNING)
                      showDialogEmail(context, widget.value[index]);
                  },
                  child: merchandisItem(context, index),
                ),
                itemCount: widget.value.length,
              ),
            ),
            isLoading
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/icons/loading.gif",
                      width: 40,
                      height: 40,
                    ),
                  )
                : Container()
          ],
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
              child: widget.value[index]["image"] != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage.assetNetwork(
                        image: Common.rootUrl + widget.value[index]["image"],
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
                    "${widget.value[index]["nameMerchandise"]}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.keyCheck == MerchandiseStatusMore.INFOR
                              ? "Số lượng bán: "
                              : "Số lượng còn: ",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          "${widget.value[index]["countsp"]}",
                          style: TextStyle(
                              fontSize: 11,
                              color:
                                  widget.keyCheck == MerchandiseStatusMore.INFOR
                                      ? Colors.blue
                                      : Colors.red),
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
                                "${Common.CURRENCY_FORMAT.format(widget.value[index]["inputPrice"])} VND",
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
                                "${Common.CURRENCY_FORMAT.format(widget.value[index]["outputPrice"])} VND",
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

  void showDialogEmail(context, value) {
    TextEditingController count = new TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Nhập số lượng muốn nhập!",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: TextFormField(
                        controller: count,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: "Số lượng"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              sendEmail(context, count.text, value);
                            },
                            child: Container(
                              width: 100,
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[500],
                                        blurRadius: 3,
                                        offset: Offset(3, 3))
                                  ]),
                              child: Text(
                                "Gửi Email",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
//                              sendEmail(context);
                            },
                            child: Container(
                              width: 100,
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 8, bottom: 8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[500],
                                        blurRadius: 3,
                                        offset: Offset(3, 3))
                                  ]),
                              child: Text(
                                "Hủy",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  void sendEmail(BuildContext context, count, value) {
//    var data = {
//      "shopName": Common.selectedShop["name"],
//      "address": Common.selectedShop["address"],
//      "merchandiseName": value["nameMerchandise"],
//      "barcode": value["barcode"],
//      "count": int.parse(count),
//      "phoneNumber": Common.selectedShop["phoneNumber"]
//    };
    setState(() {
      isLoading = true;
    });
    appDataHelper
        .sendEmail(
            shopName: Common.selectedShop["name"],
            barcode: value["barcode"],
            count: int.parse(count),
            address: Common.selectedShop["address"],
            phoneNumber: Common.selectedShop["phoneNumber"],
            merchandiseName: value["nameMerchandise"])
        .then((value) {
      setState(() {
        isLoading = false;
      });
      scafolldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          "Gửi mail thành công",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 4,
        duration: Duration(seconds: 2),
      ));
    }).catchError((err) {
      print(err);
      scafolldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Gửi mail không thành công",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 4,
        duration: Duration(seconds: 2),
      ));
      setState(() {
        isLoading = false;
      });
    });
  }
}
