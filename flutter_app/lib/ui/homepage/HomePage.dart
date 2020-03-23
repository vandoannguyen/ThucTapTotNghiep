import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/ui/homepage/warehouse/Warehouse.dart';

import 'HomePagePresenter.dart';
import 'HomePageView.dart';
import 'HomePageViewModel.dart';
import 'fill_date/FildDate.dart';
import 'merchandise_status/MerchandisStatus.dart';
import 'over_view/OverView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomePageView {
  HomePageViewModel _viewModel;
  HomePagePresenter<HomePageView> _presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new HomePageViewModel();
    _presenter = new HomePagePresenter<HomePageView>(_viewModel);
    _presenter.intiView(this);
    _presenter.getHangBanChay();
    _presenter.getHangSapHet();
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Container(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${Common.selectedShop["name"]}",
              style: TextStyle(color: Colors.white),
            )
          ],
        )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FillDate(_viewModel,
                    title: "Tuần qua",
                    fromDate: "2/2/2019",
                    toDate: "2/3/2019"),
                SizedBox(
                  height: 15,
                ),
                OverView(),
                MerchandiseStatus(_viewModel, MerchandiseStatus.INFOR),
                Warehouse(_viewModel),
                MerchandiseStatus(_viewModel, MerchandiseStatus.WARNING),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void updateUI(dynamic) {
    setState(() {});
  }

  @override
  void updateBestSeller(data) {}
}
