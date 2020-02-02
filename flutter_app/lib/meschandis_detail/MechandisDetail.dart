import 'package:flutter/material.dart';
import 'package:init_app/meschandis_detail/MerchandisPresenter.dart';
import 'package:init_app/meschandis_detail/MerchandisViewModel.dart';
import 'package:init_app/utils/BaseView.dart';

class MerchandisDetail extends StatefulWidget {
  @override
  _MerchandisDetailState createState() => _MerchandisDetailState();
}

class _MerchandisDetailState extends State<MerchandisDetail>
    implements BaseView {
  MerchandisPresenter _presenter;
  MerchandisViewModel _viewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = new MerchandisViewModel();
    _presenter = new MerchandisPresenter(_viewModel);
    _presenter.intiView(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin hàng"),
      ),
      body: Container(),
    );
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }
}
