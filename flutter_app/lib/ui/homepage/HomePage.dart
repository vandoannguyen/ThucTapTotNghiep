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
    _presenter.getPersonnels(Common.selectedShop["idShop"]);
    _presenter.getDayOfWeek();
    _presenter.getBestSeller();
    _presenter.getBills();
    _presenter.getWillBeEmpty();
    _presenter.getMerchandises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _viewModel.scaffKeyHomePage,
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
            GestureDetector(
              onTap: () {
                _presenter.shopNameClick(context);
              },
              child: Container(
                color: Colors.transparent,
                height: 60,
                alignment: Alignment.center,
                child: Text(
                  "${Common.selectedShop["name"]}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
                StreamBuilder(
                  stream: _presenter.getStream(_presenter.DAY_OF_WEEK),
                  builder: (context, snap) => FillDate(
                    snap.data,
                    _viewModel,
                    onClickFromDate: () {
                      _presenter.onClickFromDate(context);
                    },
                    onClickToDate: () {
                      _presenter.onClickToDate(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder(
                  stream: _presenter.getStream(_presenter.OVERLAY_IN_BILL),
                  builder: (ctx, snap) => OverView(snap.data),
                ),
                StreamBuilder(
                    stream: _presenter.getStream(_presenter.BEST_SALE),
                    builder: (cont, snap) {
                      return MerchandiseStatus(
                          snap.data, MerchandiseStatus.INFOR);
                    }),
                StreamBuilder(
                  stream: _presenter.getStream(_presenter.WAREHOUSE),
                  builder: (ctx, snap) {
                    return Warehouse(snap.data);
                  },
                ),
                StreamBuilder(
                  stream: _presenter.getStream(_presenter.WARNING),
                  builder: (ctx, snap) =>
                      MerchandiseStatus(snap.data, MerchandiseStatus.WARNING),
                ),
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _presenter.onDispose();
  }

  @override
  void updateBestSeller(data) {}
}
