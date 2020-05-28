import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/homepage/HomePagePresenter.dart';
import 'package:init_app/ui/list_shop/ListShopView.dart';
import 'package:init_app/ui/list_shop/ListShopViewModel.dart';
import 'package:init_app/ui/list_shop/ListshopPresenter.dart';
import 'package:init_app/ui/shop/ShopDetail.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';

class ListShop extends StatefulWidget {
  @override
  _ListShopState createState() => _ListShopState();
}

class _ListShopState extends State<ListShop> implements ListShopView {
  ListShopViewPresenter _presenter;
  ListShopViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new ListShopViewModel();
    _presenter = new ListShopViewPresenter(_viewModel);
    _presenter.intiView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _viewModel.scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Icon(
              Icons.arrow_back_ios,
              size: 17,
            ),
          ),
        ),
        centerTitle: true,
        title: Text("Danh sách cửa hàng"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _presenter.intentThemCuaHang(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        child: StreamBuilder(
          builder: (ctx, snap) => snap.data is BlocLoading
              ? Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/loading.gif",
                    width: 30,
                    height: 30,
                  ),
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () {
                      intentThongTinCuaHang(context, index);
                    },
                    onLongPress: () {
                      showDialogDelete(context, Common.shops[index]);
                    },
                    child: ItemShop(Common.shops[index]),
                  ),
                  itemCount: Common.shops.length,
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _presenter.onDispose();
  }

  void intentThongTinCuaHang(BuildContext context, int index) {
    IntentAnimation.intentNomal(
            context: context,
            screen: ShopDetail(
              keyCheck: "detail",
              value: Common.shops[index],
            ),
            option: IntentAnimationOption.RIGHT_TO_LEFT,
            duration: Duration(milliseconds: 500))
        .then((value) {
          print("sdfjjsldkfjs");
      _presenter.getListShop();
    });
  }

  void showDialogDelete(BuildContext context, shop) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Bạn có muốn xóa của hàng này không?'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Xóa cửa hàng sẽ xóa toàn bộ dữ liệu của cửa hàng!'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, "OK");
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.red,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              "Xóa",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, "");
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              "Không",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (value == "OK") {
        _presenter.deleteShop(context, shop["idShop"]);
      }
    });
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }
}
