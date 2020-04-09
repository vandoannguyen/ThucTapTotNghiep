import 'package:flutter/material.dart';
import 'package:init_app/ui/billpage/BillPage.dart';
import 'package:init_app/ui/homepage/HomePage.dart';
import 'package:init_app/ui/merchandis_page/MerchandisPage.dart';
import 'package:init_app/ui/more/ModePage.dart';
import 'package:init_app/utils/BaseView.dart';

import 'HomePresenter.dart';
import 'HomeViewModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements BaseView {
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
              onPageChanged: (index) {
                _presenter
                    .getSink(_presenter.PAGE_CHANGE)
                    .add(new BlocPageChangeEvent(index));
              },
              physics: ScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                HomePage(),
                BillPage(),
                MerchandisPage(),
//                Container(
//                  color: Colors.orange,
//                ),
                MorePage(),
              ],
            ),
          ),
          Container(
              child: StreamBuilder(
            stream: _presenter.getStream(_presenter.PAGE_CHANGE),
            builder: (ctx, snap) => BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _viewmodel.curentIndexNavBar = index;
                });
                _pageController.jumpToPage(index);
              },
              elevation: 4,
              unselectedItemColor: Colors.grey[700],
              selectedItemColor: Colors.blue,
              currentIndex:
                  snap.data is BlocPageChangeEvent ? snap.data.index : 0,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 12),
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              showUnselectedLabels: true,
              selectedIconTheme: IconThemeData(color: Colors.blue),
              unselectedIconTheme: IconThemeData(color: Colors.grey),
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
                  icon: Icon(Icons.info),
                  title: Text(
                    "Thông tin",
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  bottomNavigationBarTitleStyle() {
    return new TextStyle(color: Colors.blue);
  }

  bottomNavigationIconSize() {}

  void bottomNavOnTap(int index) {}

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
          icon: Icon(Icons.info),
          title: Text(
            "Thông tin",
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
