import 'package:intl/intl.dart';

class Common {
  static final CHANNEL = "com.example.init_app";

  static var config = {};

  static var rootUrlApi = "http://192.168.0.106:3000/api/";
  static var rootUrl = "http://192.168.0.106:3000/";

  static String loginToken = "";
  static dynamic user = {};

  static var selectedShop = {};
  static var shops = [];
  static var heightOfScreen = 0.0;
  static var widthOfScreen = 0.0;
  static final CURRENCY_FORMAT = NumberFormat("#,###,###,##0", "en_US");
  static final String KEY_CHECK_CREATE_SHOP = "create";
}
