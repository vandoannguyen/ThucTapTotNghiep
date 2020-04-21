import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'PersonnelView.dart';

class PersonnelPresenter<V extends PersonnelView> extends BasePresenter<V> {
  static final String GET_LIST_PERSONNEL = "GET_LIST_PERSONNEL";
  IAppDataHelper appDataHelper;

  PersonnelPresenter() : super() {
    appDataHelper = new AppDataHelper();
    addStreamController(GET_LIST_PERSONNEL);
  }

  void getPersonnel() {
    getSink(GET_LIST_PERSONNEL).add(new BlocLoading());
    appDataHelper.getPersonnels(Common.selectedShop["idShop"]).then((value) {
      getSink(GET_LIST_PERSONNEL).add(new BlocLoaded(value));
    }).catchError((err) {
      getSink(GET_LIST_PERSONNEL).add(new BlocFailed("Loading faild"));

      print(err);
    });
  }
}
