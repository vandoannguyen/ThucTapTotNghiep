import 'package:flutter/cupertino.dart';
import 'package:init_app/utils/BaseView.dart';

abstract class CategoryView extends BaseView {
  void showSnackBar({@required keyInput, mess});
}
