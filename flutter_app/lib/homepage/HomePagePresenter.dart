import 'package:init_app/homepage/HomePageViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';

class HomePagePresenter implements BasePresenter {
  HomePageViewModel _viewModel;
  BaseView _baseView;
  HomePagePresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    _baseView = baseView;
  }
}
