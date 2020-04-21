abstract class IApiHelper {
  Future postLogin(user);

  Future getListBill(isShop);

  Future getBillByDay(idShop, startDate, endDate, status);

  Future getCategories(idShop);

  Future addCategory(isShop, String str);

  Future createBill(bill);

  Future getMerchandisesByBill(idBill, idShop);

  Future getPersonnelByBill(idPersonnel);

  Future getMerchandisesByShop(idShop);

  Future getMerchandisesFillByCategory(idShop);

  Future createCategory(idShop, nameCategory);

  Future createMerchandise(data);

  Future updatePassword(idUser, password);

  Future registerAccount(data);

  Future getPersonnels(idShop);

  Future createPersonnel(data);

  Future createShop(data);

  Future updateMerchandise(data);

  Future getBestSeller(idShop, limits, fromDate, toDate);

  Future getWillBeEmpty(idShop, warningCount);
}
