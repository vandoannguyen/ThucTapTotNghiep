//class to handle event of user from screen and excution
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';
import 'package:init_app/utils/BlogEvent.dart';

import 'HomeViewModel.dart';

class HomePresenter extends BasePresenter {
  BaseView baseView;
  HomeViewModel _viewModel;

  var PAGE_CHANGE = "pagechange";

  HomePresenter(this._viewModel) {
    addStreamController(PAGE_CHANGE);
  }

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }
}

class BlocPageChangeEvent extends BlocEvent {
  int index;

  BlocPageChangeEvent(this.index);
}
