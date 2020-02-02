import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class ListMerchandis extends StatefulWidget {
  @override
  _ListMerchandisState createState() => _ListMerchandisState();
}

class _ListMerchandisState extends State<ListMerchandis> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            IntentAnimation.intentBack(context: context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 17,
            color: Colors.black54,
          ),
        ),
        title: Text("Danh sách sản phẩm"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              themSanPham();
            },
            icon: Icon(
              Icons.add,
              size: 25,
              color: Colors.black54,
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => categoryItem(index),
                    itemCount: 15,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                        itemBuilder: (ctx, index) => merchandisItem(index),
                        itemCount: 30,
                        scrollDirection: Axis.vertical,
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          height: Common.heightOfScreen,
                          width: Common.widthOfScreen,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  height: Common.heightOfScreen / 5,
                                  child: Image.asset(
                                      "assets/icons/add_merchandis.png"),
                                ),
                                Text(
                                  "Loại hàng này chưa có hàng\n Click để thêm...",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.blue),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Visibility(
              visible: isLoading,
              child: Container(
                  alignment: Alignment.center,
                  width: Common.widthOfScreen,
                  height: Common.heightOfScreen,
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Loading ....")
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  categoryItem(int index) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 3,
        color: index == 0 ? Colors.blue : Colors.white,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Text(
            "Dầu gội",
            style: TextStyle(
                color: index == 0 ? Colors.white : Colors.blue, fontSize: 17),
          ),
        ),
      ),
    );
  }

  merchandisItem(int index) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 70,
          child: Row(
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/images/default_image.png",
                  height: Common.heightOfScreen / 10,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Tên hàng",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Có thể bán: ",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            "1000",
                            style: TextStyle(fontSize: 13, color: Colors.blue),
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
      ),
    );
  }

  void themSanPham() {}
}
