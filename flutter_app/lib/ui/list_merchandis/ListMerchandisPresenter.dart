import 'package:init_app/common/Common.dart';
import 'package:init_app/data/AppDataHelper.dart';
import 'package:init_app/ui/meschandis_detail/MechandisDetail.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/IntentAnimation.dart';

import 'ListMerchandisView.dart';
import 'ListMerchandisViewModel.dart';

class ListMerchandisPresenter<V extends ListMerchandisView>
    extends BasePresenter<V> {
  IAppDataHelper appDataHelper;
  ListMerchandisViewModel _viewModel;

  ListMerchandisPresenter(this._viewModel) {
    appDataHelper = new AppDataHelper();
  }

  void getData() async {
    appDataHelper
        .getMerchandisesFillByCategory(Common.selectedShop["idShop"])
        .then((value) {
      print(value);
      var data = value;
      print(data);
      _viewModel.categories = data.map((element) {
        element["selected"] = false;
        return element;
      }).toList();
      _viewModel.categories[0]["selected"] = true;
      _viewModel.selectedCategory = _viewModel.categories[0];
      _viewModel.selectedListMerchandise =
          _viewModel.selectedCategory["listMechandise"];
      baseView.updateUI({});
    }).catchError((err) {
      print(err);
    });
  }

  void addMerchandise(context) {
    IntentAnimation.intentNomal(
        context: context,
        screen: MerchandiseDetail(
          inputKey: MerchandiseDetail.CREATE,
        ),
        option: IntentAnimationOption.RIGHT_TO_LEFT,
        duration: Duration(milliseconds: 500));
  }
}
