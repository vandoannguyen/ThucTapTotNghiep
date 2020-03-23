import 'package:init_app/utils/BaseView.dart';

class BasePresenter<V extends BaseView> {
  V baseView;

  void intiView(V baseView) {
    this.baseView = baseView;
  }
}
