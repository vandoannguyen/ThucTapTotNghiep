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
  Future<String> getPass() {
    // TODO: implement getPass
    return sharePreferHelper.getPass();
  }

  @override
  Future getRememberMe() {
    // TODO: implement getRememberMe
    return sharePreferHelper.getRememberMe();
  }

  @override
  Future<String> getUser() {
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
}
