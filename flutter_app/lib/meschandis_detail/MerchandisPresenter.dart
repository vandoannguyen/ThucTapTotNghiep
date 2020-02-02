import 'package:init_app/meschandis_detail/MerchandisViewModel.dart';
import 'package:init_app/utils/BasePresenter.dart';
import 'package:init_app/utils/BaseView.dart';

class MerchandisPresenter implements BasePresenter {
  BaseView baseView;
  MerchandisViewModel _viewModel;

  MerchandisPresenter(this._viewModel);

  @override
  void intiView(BaseView baseView) {
    // TODO: implement intiView
    this.baseView = baseView;
  }
}
