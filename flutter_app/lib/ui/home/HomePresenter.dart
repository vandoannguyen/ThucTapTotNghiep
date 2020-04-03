//class to handle event of user from screen and excution
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';

import 'HomeViewModel.dart';

class HomePresenter extends BasePresenter {
  BaseView baseView;
  HomeViewModel _viewModel;

  HomePresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }
}
