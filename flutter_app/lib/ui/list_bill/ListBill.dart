import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/create_bill/CreateBill.dart';
import 'package:init_app/ui/list_bill/ListBillPressenter.dart';
import 'package:init_app/ui/list_bill/ListBillView.dart';
import 'package:init_app/ui/list_bill/ListBillViewModel.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import '../billpage/ItemHoaDon.dart';

class ListBill extends StatefulWidget {
  dynamic listData;

  ListBill(this.listData);

  @override
  _ListBillState createState() => _ListBillState();
}

class _ListBillState extends State<ListBill> implements ListBillView {
  ListBillPresenter<ListBillView> _presenter;
  ListBillViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new ListBillViewModel();
    _presenter = new ListBillPresenter<ListBillView>(_viewModel);
    _presenter.intiView(this);
    _presenter.getDayOfWeek();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listData == null) widget.listData = [];
    return Scaffold(
        key: _viewModel.scaffoldKey,
        appBar: AppBar(
          title: Text("Danh sách đơn hàng"),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Trong khoảng thời gian",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      StreamBuilder(
                        stream:
                            _presenter.getStream(ListBillPresenter.DAY_OF_WEEK),
                        builder: (ctx, snap) => snap.data is BlocLoaded
                            ? Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: DateFill(Common.DATE_FORMAT(
                                          snap.data.value["firstDay"])),
                                      onTap: () {
                                        _presenter.pressFromDate(context);
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text("-"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _presenter.pressToDate(context);
                                      },
                                      child: DateFill(Common.DATE_FORMAT(
                                          snap.data.value["endDay"])),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: _presenter
                                .getStream(ListBillPresenter.BUTTON_FILL),
                            builder: (ctx, snap) => snap.data is BlocLoaded
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            _presenter.pressDonXuat();
                                          },
                                          child: ButtonFill(
                                              "Đơn xuất", snap.data.value),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _presenter.pressDonNhap();
                                          },
                                          child: ButtonFill(
                                              "Đơn nhập", !snap.data.value),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            _presenter.pressDonXuat();
                                          },
                                          child: ButtonFill("Đơn xuất",
                                              _viewModel.isExportBill),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _presenter.pressDonNhap();
                                          },
                                          child: ButtonFill("Đơn nhập",
                                              !_viewModel.isExportBill),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 0.5,
                            color: Colors.grey,
                            margin: EdgeInsets.only(left: 10, right: 10),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Sắp xếp theo:",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _presenter.pressFillOption(context);
                                  },
                                  child: Card(
                                      elevation: 4,
                                      child: StreamBuilder(
                                        stream: _presenter.getStream(
                                            ListBillPresenter.CHOSE_OPTION),
                                        builder: (ctx, snap) => snap.data
                                                is BlocLoaded
                                            ? Container(
                                                padding: EdgeInsets.all(5),
                                                child: Text(snap.data.value),
                                              )
                                            : Container(
                                                padding: EdgeInsets.all(5),
                                                child: Text("Ngày tạo"),
                                              ),
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _presenter.pressOrder();
                                  },
                                  child: Card(
                                    elevation: 4,
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      child: StreamBuilder(
                                        stream: _presenter.getStream(
                                            ListBillPresenter.ORDER_STATUS),
                                        builder: (ctx, snap) =>
                                            snap.data is BlocLoaded
                                                ? Icon(
                                                    _viewModel.order == "up"
                                                        ? Icons.arrow_upward
                                                        : Icons.arrow_downward,
                                                    size: 18,
                                                  )
                                                : Icon(
                                                    _viewModel.order == "up"
                                                        ? Icons.arrow_upward
                                                        : Icons.arrow_downward,
                                                    size: 18,
                                                  ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder(
                              stream: _presenter
                                  .getStream(ListBillPresenter.LIST_BILL),
                              builder: (ctx, snap) => snap.data is BlocLoaded
                                  ? snap.data.value.length > 0
                                      ? ListView.builder(
                                          itemBuilder: (ctx, index) =>
                                              GestureDetector(
                                            child: ItemHoaDon(
                                                snap.data.value[index]),
                                            onTap: () {
                                              detailBill(context, index);
                                            },
                                          ),
                                          itemCount: snap.data.value.length,
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Image.asset(
                                                "assets/images/list_bill_empty.png",
                                                width: 100,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "List is empty",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        )
                                  : snap.data is BlocLoading
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/icons/loading.gif",
                                            width: 30,
                                            height: 30,
                                          ),
                                        )
                                      : Container(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  void detailBill(BuildContext context, index) {
    IntentAnimation.intentNomal(
        context: context,
        screen: CreateBill(
          keyCheck: "detail",
          value: widget.listData[index],
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }

  @override
  void showMess(isErr, mess) {
    // TODO: implement showMess
    print(mess);
    _viewModel.scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
        mess,
        style: TextStyle(color: Colors.white),
      ),
      elevation: 4,
      backgroundColor: isErr ? Colors.red : Colors.blue,
      duration: Duration(seconds: 2),
    ));
  }
}

class ButtonFill extends StatelessWidget {
  String title;
  bool isSelected;

  ButtonFill(this.title, this.isSelected);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      color: isSelected ? Colors.blue : Colors.white,
      elevation: 4,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        padding: EdgeInsets.all(10),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
        ),
      ),
    );
  }
}

class DateFill extends StatelessWidget {
  String date;

  DateFill(this.date);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: 16,
            ),
            SizedBox(
              width: 5,
            ),
            Text(date)
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
