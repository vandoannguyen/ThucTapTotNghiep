import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/image_provider.dart';

class ShopDetailViewModel {
  FileImage avatarImage;
  String base64Image;
  TextEditingController shopNameCtrl,
      addressCtrl,
      phoneNumberCtrl,
      warningCountEditCtrl,
      descriptionCtrl;
  FocusNode fcNameShop, fcAdd, fcPhonenum, fcDess;

  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;

  bool isEditEnable = true;

  ShopDetailViewModel() {
    shopNameCtrl = new TextEditingController();
    addressCtrl = new TextEditingController();
    phoneNumberCtrl = new TextEditingController();
    descriptionCtrl = new TextEditingController();
    warningCountEditCtrl = new TextEditingController();

    fcNameShop = new FocusNode();
    fcAdd = new FocusNode();
    fcPhonenum = new FocusNode();
    fcDess = new FocusNode();
    formKey = new GlobalKey();
    scaffoldKey = new GlobalKey();
  }
}
