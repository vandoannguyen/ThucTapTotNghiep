import 'dart:wasm';

import 'package:init_app/data/api/ApiHelper.dart';
import 'package:init_app/data/api/IApiHelper.dart';
import 'package:init_app/data/share_prefer/SharepreferHelper.dart';

abstract class IAppDataHelper extends IApiHelper with ISharepreferHelper {}

class AppDataHelper implements IAppDataHelper {
  IApiHelper apiHelper;
  ISharepreferHelper sharePreferHelper;

  AppDataHelper() {
    apiHelper = new ApiHelper();
    sharePreferHelper = new SharepreferHelper();
  }

  @override
  Future postLogin(user) {
    // TODO: implement postLogin
    return apiHelper.postLogin(user);
  }

  @override
  Future getPass() {
    // TODO: implement getPass
    return sharePreferHelper.getPass();
  }

  @override
  Future getRememberMe() {
    // TODO: implement getRememberMe
    return sharePreferHelper.getRememberMe();
  }

  @override
  Future getUser() {
    // TODO: implement getUser
    return sharePreferHelper.getUser();
  }

  @override
  Future rememberMe(value) {
    // TODO: implement rememberMe
    return sharePreferHelper.rememberMe(value);
  }

  @override
  Future<Void> savePass(str) {
    // TODO: implement savePass
    return sharePreferHelper.savePass(str);
  }

  @override
  Future<Void> saveUserName(str) {
    // TODO: implement saveUserName
    return sharePreferHelper.saveUserName(str);
  }

  @override
  Future getListBill(isShop) {
    // TODO: implement getListBill
    return apiHelper.getListBill(isShop);
  }

  @override
  Future getBillByDay(idShop, startDate, endDate, status) {
    // TODO: implement getBillCurrentDay
    return apiHelper.getBillByDay(idShop, startDate, endDate, status);
  }

  @override
  Future getCategories(idShop) {
    // TODO: implement getCategories
    return apiHelper.getCategories(idShop);
  }

  @override
  Future addCategory(isShop, String str) {
    // TODO: implement addCategory
    return apiHelper.addCategory(isShop, str);
  }

  @override
  Future createBill(bill) {
    // TODO: implement createBill
    return apiHelper.createBill(bill);
  }

  @override
  Future getMerchandisesByBill(idBill, idShop) {
    // TODO: implement getMerchandisesByBill
    return apiHelper.getMerchandisesByBill(idBill, idShop);
  }

  @override
  Future getMerchandisesByShop(idShop) {
    // TODO: implement getMerchandisesByShop
    return apiHelper.getMerchandisesByShop(idShop);
  }

  @override
  Future getMerchandisesFillByCategory(idShop) {
    // TODO: implement getMerchandisesFillByCategory
    return apiHelper.getMerchandisesFillByCategory(idShop);
  }

  @override
  Future createCategory(idShop, nameCategory) {
    // TODO: implement createCategory
    return apiHelper.createCategory(idShop, nameCategory);
  }

  @override
  Future createMerchandise(data) {
    // TODO: implement createMerchandise
    return apiHelper.createMerchandise(data);
  }

  @override
  Future updatePassword(idUser, password) {
    // TODO: implement updatePassword
    return apiHelper.updatePassword(idUser, password);
  }

  @override
  Future registerAccount(data) {
    // TODO: implement registerAccount
    return apiHelper.registerAccount(data);
  }

  @override
  Future createShop(data) {
    // TODO: implement createShop
    return apiHelper.createShop(data);
  }

  @override
  Future updateMerchandise(data) {
    // TODO: implement updateMerchandise
    return apiHelper.updateMerchandise(data);
  }

  @override
  Future getBestSeller(idShop, limits, fromDate, toDate) {
    // TODO: implement getBestSeller
    return apiHelper.getBestSeller(idShop, limits, fromDate, toDate);
  }

  @override
  Future getWillBeEmpty(idShop, warningCount) {
    // TODO: implement getWillBeEmpty
    return apiHelper.getWillBeEmpty(idShop, warningCount);
  }

  @override
  Future getPersonnelByBill(idPersonel) {
    // TODO: implement getPersonelByBill
    return apiHelper.getPersonnelByBill(idPersonel);
  }

  @override
  Future createPersonnel(data) {
    // TODO: implement createPersonnel
    return apiHelper.createPersonnel(data);
  }

  @override
  Future getPersonnels(idShop) {
    // TODO: implement getPersonnels
    return apiHelper.getPersonnels(idShop);
  }

  @override
  Future updateUser(user) {
    // TODO: implement updateUser
    return apiHelper.updateUser(user);
  }

  @override
  Future deletePersonnel(idUser) {
    // TODO: implement deletePersonnel
    return apiHelper.deletePersonnel(idUser);
  }

  @override
  Future updateShop(data) {
    // TODO: implement updateShop
    return apiHelper.updateShop(data);
  }

  @override
  Future deleteMerchandise(barcode, idShop) {
    // TODO: implement deleteMerchandise
    return apiHelper.deleteMerchandise(barcode, idShop);
  }

  @override
  Future deleteCategory(idCategory, idNoCategory, idShop) {
    // TODO: implement deleteCategory
    return apiHelper.deleteCategory(idCategory, idNoCategory, idShop);
  }

  @override
  Future deleteShop(idShop) {
    // TODO: implement deleteShop
    return apiHelper.deleteShop(idShop);
  }

  @override
  Future sendEmail(
      {shopName, merchandiseName, count, phoneNumber, address, barcode}) {
    // TODO: implement sendEmail
    return apiHelper.sendEmail(
        shopName: shopName,
        merchandiseName: merchandiseName,
        count: count,
        phoneNumber: phoneNumber,
        address: address,
        barcode: barcode);
  }

  @override
  Future updateCategory(idCategory, name) {
    // TODO: implement updateCategory
    return apiHelper.updateCategory(idCategory, name);
  }

  @override
  Future getListShop(idUser) {
    // TODO: implement getListShop
    return apiHelper.getListShop(idUser);
  }
}
