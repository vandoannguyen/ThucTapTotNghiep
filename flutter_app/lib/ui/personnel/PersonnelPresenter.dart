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
                    child: Card(
                      color: Colors.red,
                      elevation: 4,
                      child: Container(
                        width: 80,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Text(
                          "Có",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context, "NO");
                    },
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: 80,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Text(
                          "KHÔNG",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ))
              ],
            ));
    if (value == "OK") {
      appDataHelper
          .deletePersonnel(_viewModel.personnels[index]["idPersonnel"])
          .then((value) {
        getPersonnel();
        _viewModel.scaffKey.currentState.showSnackBar(SnackBar(
          content: Text(value),
          elevation: 4,
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ));
      }).catchError((err) {
        print(err);
      });
    }
  }
}
