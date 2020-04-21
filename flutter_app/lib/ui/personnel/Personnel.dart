import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/personnel/PersonnelPresenter.dart';
import 'package:init_app/ui/personnel/PersonnelViewModel.dart';
import 'package:init_app/ui/register/Register.dart';
import 'package:init_app/utils/BlogEvent.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'PersonnelView.dart';

class Personnel extends StatefulWidget {
  @override
  _PersonnelState createState() => _PersonnelState();
}

class _PersonnelState extends State<Personnel> implements PersonnelView {
  PersonnelPresenter _presenter;
  PersonnelViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    _presenter = new PersonnelPresenter();
    _presenter.intiView(this);
    _viewModel = new PersonnelViewModel();
    _presenter.getPersonnel();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _presenter.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Nhân viên"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              intentToRegister(context);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: _presenter.getStream(PersonnelPresenter.GET_LIST_PERSONNEL),
          builder: (ctx, snap) => snap.data is BlocLoading
              ? Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/loading.gif",
                    width: 30,
                    height: 30,
                  ),
                )
              : snap.data is BlocLoaded
                  ? snap.data.value.length > 0
                      ? ListView.builder(
                          itemBuilder: (ctx, index) =>
                              itemNhanVien(snap.data.value[index]),
                          itemCount: snap.data.value.length,
                        )
                      : GestureDetector(
                          onTap: () {
                            intentToRegister(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/icons/icon_add_user.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                        )
                  : Container(),
        ),
      ),
    );
  }

  itemNhanVien(data) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        width: Common.widthOfScreen - 50,
        child: Row(
          children: <Widget>[
            Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  child: data["image"] != ""
                      ? FadeInImage.assetNetwork(
                          placeholder: "assets/images/defAvatar.png",
                          image: Common.rootUrl + data["image"],
                          fit: BoxFit.fill,
                        )
                      : Image.asset("assets/images/defAvatar.png",
                          fit: BoxFit.fill),
                )),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${data["name"]}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.blue,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("${data["email"]}"),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.blue,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ngày thêm ${Common.DATE_FORMAT(DateTime.parse(data["createDate"]))}",
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }

  void intentToRegister(BuildContext context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: Register(Register.ADD_PERSONEL),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 800));
  }
}
