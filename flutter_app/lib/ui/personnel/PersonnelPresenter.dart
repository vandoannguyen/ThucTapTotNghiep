import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/personnel/PersonnelViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'PersonnelView.dart';

class PersonnelPresenter<V extends PersonnelView> extends BasePresenter<V> {
  static final String GET_LIST_PERSONNEL = "GET_LIST_PERSONNEL";
  IAppDataHelper appDataHelper;
  PersonnelViewModel _viewModel;

  PersonnelPresenter(PersonnelViewModel viewModel) : super() {
    appDataHelper = new AppDataHelper();
    _viewModel = viewModel;
    addStreamController(GET_LIST_PERSONNEL);
  }

  void getPersonnel() {
    getSink(GET_LIST_PERSONNEL).add(new BlocLoading());
    appDataHelper.getPersonnels(Common.selectedShop["idShop"]).then((value) {
      _viewModel.personnels =
          value.where((element) => element["status"] == 1).toList();
      getSink(GET_LIST_PERSONNEL).add(new BlocLoaded(_viewModel.personnels));
    }).catchError((err) {
      getSink(GET_LIST_PERSONNEL).add(new BlocFailed("Loading faild"));

      print(err);
    });
  }

  void showDialogDelete(BuildContext context, index) async {
    String value = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Bạn có muốn xóa nhân viên này ?"),
              actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context, "OK");
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.centerRight,
                      color: Colors.transparent,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Có",
                        style: TextStyle(color: Colors.red),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context, "NO");
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "KHÔNG",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ))
              ],
            ));
    if (value == "OK") {
      appDataHelper
          .deletePersonnel(_viewModel.personnels[index]["idPersonnel"])
          .then((value) {
        print(value);
      }).catchError((err) {
        print(err);
      });
    }
  }
}
