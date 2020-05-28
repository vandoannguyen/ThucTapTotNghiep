import 'package:flutter/material.dart';

class MerchandiseDetailViewModel {
  var isEditing = true;

  GlobalKey<FormState> formKey;

  TextEditingController tenSpControl,
      barcodeControl,
      descriptionController,
      inputPriceController,
      outputPriceController,
      totalMerchandiseController,
      emailProvider;
  dynamic categories = [];

  FileImage avatarImage;

  String base64Image = '';
  var selectedCategory = {};

  dynamic value = {};

  GlobalKey<ScaffoldState> scaffoldKey;

  bool updateSuccess;
  MerchandiseDetailViewModel() {
    updateSuccess = false;
    scaffoldKey = new GlobalKey();
    formKey = new GlobalKey();
    tenSpControl = new TextEditingController();
    barcodeControl = new TextEditingController();
    descriptionController = new TextEditingController();
    inputPriceController = new TextEditingController();
    outputPriceController = new TextEditingController();
    totalMerchandiseController = new TextEditingController();
    emailProvider = new TextEditingController();
  }
}
