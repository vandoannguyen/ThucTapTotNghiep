import 'package:flutter/material.dart';

class MerchandisDetailViewModel {
  var isEditting = true;

  GlobalKey<FormState> formKey;

  TextEditingController tenSpControl,
      barcodeControl,
      motaController,
      giaNhapController,
      giaBanController,
      soLuongTrongKhoController;
  dynamic categiroes = [];

  FileImage avatarImage;

  String base64Image = '';
  var selectedCategoty = {};

  dynamic value = {};
  MerchandisDetailViewModel() {
    formKey = new GlobalKey();
    tenSpControl = new TextEditingController();
    barcodeControl = new TextEditingController();
    motaController = new TextEditingController();
    giaNhapController = new TextEditingController();
    giaBanController = new TextEditingController();
    soLuongTrongKhoController = new TextEditingController();
  }
}
