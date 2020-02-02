import 'package:flutter/material.dart';
import 'package:init_app/home/HomePresenter.dart';
import 'package:init_app/home/billpage/BillPage.dart';
import 'package:init_app/home/homepage/HomePage.dart';
import 'package:init_app/utils/BaseView.dart';

import 'HomeViewModel.dart';
import 'merchandis_page/MerchandisPage.dart';

class HomeScreen extends StatelessWidget implements BaseView {
  HomeViewModel _viewmodel;
  HomePresenter _presenter;
  PageController _pageController;
  @override
  Widget build(BuildContext context) {
    _viewmodel = new HomeViewModel();
    _presenter = new HomePresenter(_viewmodel);
    _pageController =
        new PageController(initialPage: _viewmodel.curentIndexNavBar);
    _presenter.intiView(this);
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                HomePage(),
                BillPage(),
                MerchandisPage(),
                Container(
                  color: Colors.orange,
                ),
                Container(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(child: BottomNavBar(_viewmodel, _pageController))
        ],
      ),
    ));
  }

  @override
  void updateUI(dynamic) {
    // TODO: implement updateUI
  }
}

class BottomNavBar extends StatefulWidget {
  HomeViewModel _viewModel;
  PageController _pageController;
  BottomNavBar(this._viewModel, this._pageController);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          widget._viewModel.curentIndexNavBar = index;
        });
        widget._pageController.jumpToPage(index);
      },
      elevation: 4,
      unselectedItemColor: Colors.grey[700],
      selectedItemColor: Colors.blue,
      currentIndex: widget._viewModel.curentIndexNavBar,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 12),
//      unselectedLabelStyle: TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
//      selectedIconTheme: IconThemeData(color: Colors.blue),
//      unselectedIconTheme: IconThemeData(color: Colors.grey),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            "Trang chủ",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_drive_file),
          title: Text(
            "Đơn hàng",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_open),
          title: Text(
            "Sản phẩm",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          title: Text(
            "Báo cáo",
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text(
            "Cài đặt",
          ),
        ),
      ],
    );
  }

  bottomNavigationBarTitleStyle() {
    return new TextStyle(color: Colors.blue);
  }

  bottomNavigationIconSize() {}

  void bottomNavOnTap(int index) {}
}
