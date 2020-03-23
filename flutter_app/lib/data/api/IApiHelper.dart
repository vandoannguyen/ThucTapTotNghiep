abstract class IApiHelper {
  Future postLogin(user);

  Future getListBill(isShop);

  Future getBillCurrentDay(idShop);

  Future getCategories(idShop);

  Future addCategory(isShop, String str);

  Future createBill(bill);

  Future getMerchandisesByBill(idBill, idShop);

  Future getMerchandisesByShop(idShop);

  Future getMerchandisesFillByCategory(idShop);

  Future createCategory(idShop, nameCategory);

  Future createMerchandise(data);

  Future updatePassword(idUser, password);

  Future registerAccount(data);

  Future createShop(data);

  Future updateMerchandise(data);
}
