import 'package:flutter/cupertino.dart';
import 'package:init_app/utils/BaseView.dart';

abstract class MerchandiseDetailView extends BaseView {
  void showSnackBar({@required String keyInput, String mess});
  void continueAdd();
}
