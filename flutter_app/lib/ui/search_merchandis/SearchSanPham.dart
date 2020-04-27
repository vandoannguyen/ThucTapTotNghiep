import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';
import 'package:qrscan/qrscan.dart' as scan;

import 'SearchSanPhamPresenter.dart';
import 'SearchSanPhamViewModel.dart';

class SearchSanPhamScreen extends StatefulWidget {
  @override
  _SearchSanPhamScreenState createState() => _SearchSanPhamScreenState();
}

class _SearchSanPhamScreenState extends State<SearchSanPhamScreen>
    implements BaseView {
  SearchSanPhamPresenter _presenter;
  SearchSanPhamViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = new SearchSanPhamViewModel();
    _presenter = new SearchSanPhamPresenter(_viewModel);
    _presenter.intiView(this);
    _presenter.getListSanPham();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            IntentAnimation.intentBack(context: context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 17,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        title: Container(
          height: 50,
          width: Common.widthOfScreen - 130,
          child: TextFormField(
            onChanged: (value) {
              _presenter.onTextInputChange(value);
            },
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  showBarcode(context);
                },
                icon: Icon(Icons.flip),
              ),
              hintText: "Nhập tên tìm kiếm",
              hintStyle: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
            stream: _presenter.getStream(_presenter.LIST_MERCHANDISE),
            builder: (ctx, snap) => snap.data is BlocLoading
                ? Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/icons/loading.gif",
                      width: 35,
                      height: 30,
                    ),
                  )
                : snap.data is BlocLoaded
                    ? ListView.builder(
                        itemBuilder: (ctx, index) =>
                            itemMerchandis(context, snap.data.value[index]),
                        physics: ScrollPhysics(),
                        itemCount: snap.data.value.length,
                      )
                    : snap.data is BlocFailed
                        ? Container(
                            child: Text(snap.data.mess),
                          )
                        : Container()),
      ),
    );
  }

  void showBarcode(context) async {
    var barcode = await scan.scan();
    var selectMacherdis = _viewModel.listSanPham.firstWhere(
        (element) => element["barcode"] == barcode,
        orElse: () => null);
    print(selectMacherdis);
    if (selectMacherdis != null) {
      print(selectMacherdis);
      IntentAnimation.intentBack(context: context, result: selectMacherdis);
    }
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
    setState(() {});
  }

  itemMerchandis(context, data) {
    return GestureDetector(
      onTap: () {
        IntentAnimation.intentBack(context: context, result: data);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Container(
                height: Common.widthOfScreen / 7,
                width: Common.widthOfScreen / 7,
                child: data["image"] == null || data["image"] == ""
                    ? Image.asset(
                        'assets/images/default_image.png',
                        fit: BoxFit.fill,
                      )
                    : FadeInImage.assetNetwork(
                        placeholder: "assets/images/default_image.png",
                        image: Common.rootUrl + data["image"]),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: Common.widthOfScreen / 7,
                  width: Common.widthOfScreen / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data["nameMerchandise"],
                        style: topValueStyle(),
                      ),
                      Text(
                        "Barcode: " + data["barcode"].toString(),
                        style: bottomValueStyle(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: Common.widthOfScreen / 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      data["count"].toString(),
                      style: topValueStyle(),
                    ),
                    Text(
                      "${data["count"] * data["outputPrice"]}",
                      style: bottomValueStyle(),
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

  topValueStyle() {
    return TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  }

  bottomValueStyle() {
    return TextStyle(fontSize: 14, color: Colors.grey);
  }
}
