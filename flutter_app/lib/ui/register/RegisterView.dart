import 'package:init_app/utils/BaseView.dart';

abstract class RegisterView extends BaseView {
  void backView(sts);
  void showSnackbar(String mess, String status);
}
