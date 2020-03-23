import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/api/IApiHelper.dart';

class ApiHelper implements IApiHelper {
  @override
  Future postLogin(user) {
    // TODO: implement postLogin
    Completer completer = new Completer();
    http.post("${Common.rootUrlApi}login", body: user).then((value) {
      print(value.statusCode);
      print(value.body);
      completer.complete(jsonDecode(value.body));
    }).catchError((error) {
      print(error);
      completer.completeError(error);
    });
    return completer.future;
  }

  @override
  Future getListBill(idShop) {
    Completer c = new Completer();
    http.get("${Common.rootUrlApi}bill/getListBill?idShop=${idShop}", headers: {
      HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken
    }).then((value) {
      if (value.statusCode == 200) {
        c.complete(jsonDecode(value.body));
      }
    }).catchError((err) {
      c.completeError(err);
    });
    // TODO: implement getListBill
    return c.future;
  }

  @override
  Future getBillCurrentDay(idShop) {
    Completer com = new Completer();
    if (Common.user["idRole"] == 2) {
      var now = new DateTime.now();
      print(now.toIso8601String());
      http
          .post("${Common.rootUrlApi}bill/getCurrentBills",
              headers: {
                HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
                HttpHeaders.contentTypeHeader: 'application/json'
              },
              body: jsonEncode({
                "user": Common.user,
                "date": now.toIso8601String().replaceFirst("T", " "),
                "idShop": idShop
              }))
          .then((value) {
        print(value);
        if (value.statusCode == 200) {
          com.complete(jsonDecode(value.body));
        }
      }).catchError((err) {
        com.completeError(err);
      });
    }
    // TODO: implement getBillCurrentDay
    return com.future;
  }

  @override
  Future getCategories(idShop) {
    // TODO: implement getCategories
    Completer com = new Completer();
    http.get("${Common.rootUrlApi}category/listCategory?idShop=${idShop}",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        }).then((value) {
      com.complete(jsonDecode(value.body));
    }).catchError((err) {
      com.completeError(err);
    });
    return com.future;
  }

  @override
  Future addCategory(idShop, String str) {
    // TODO: implement addCategory
    Completer com = new Completer();
    var data = {"idShop": idShop, "nameCategory": str};
    http.post("${Common.rootUrlApi}category/insert",
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        }).then((value) {
      com.complete(jsonDecode(value.body));
    }).catchError((err) {
      com.completeError(err);
    });
    return com.future;
  }

  @override
  Future createBill(bill) {
    // TODO: implement createBill
    Completer com = new Completer();
    http.post(Common.rootUrlApi + "bill/createbill",
        body: jsonEncode(bill),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${Common.loginToken}",
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.contentTypeHeader: 'application/json'
        }).then((value) {
      com.complete(jsonDecode(value.body));
    }).catchError((onError) {
      com.completeError(onError);
    });
    return com.future;
  }

  @override
  Future getMerchandisesByBill(idBill, idShop) {
    // TODO: implement getMerchandisesByBill
    Completer completer = new Completer();
    http.get(
      "${Common.rootUrlApi}merchandise/listMerchandisByBill?idBill=${idBill}&idShop=${idShop}",
      headers: {
        "Authorization": 'Bearer ' + Common.loginToken,
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      },
    ).then((value) {
      completer.complete(jsonDecode(value.toString()));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future getMerchandisesByShop(idShop) {
    // TODO: implement getMerchandisesByShop
    Completer completer = new Completer();
    http.get(
      "${Common.rootUrlApi}merchandise/listMerchandis?idShop=${Common.selectedShop["idShop"]}",
      headers: {
        "Authorization": 'Bearer ' + Common.loginToken,
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
      },
    ).then((value) {
      completer.complete(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future getMerchandisesFillByCategory(idShop) {
    // TODO: implement getMerchandisesFillByCategory
    Completer completer = new Completer();
    http.get(
        Common.rootUrlApi +
            "merchandise/list?idShop= ${Common.selectedShop["idShop"]}",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
        }).then((value) {
      completer.complete(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future createCategory(idShop, nameCategory) {
    // TODO: implement createCategory
    Completer completer = new Completer();

    return completer.future;
  }

  @override
  Future createMerchandise(data) {
    // TODO: implement createMerchandise
    print(data);
    Completer completer = new Completer();
    print(completer);
    http.post("${Common.rootUrlApi}merchandise/createMerchandise",
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        }).then((value) {
      print(value);
      completer.complete(jsonDecode(value.body));
    }).catchError((onError) {
      completer.completeError(onError);
    });
    return completer.future;
  }

  @override
  Future updatePassword(idUser, password) {
    // TODO: implement updatePassword
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}users/changepassword",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode({"idUser": idUser, "password": password}))
        .then((value) {
      completer.complete(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future registerAccount(data) {
    // TODO: implement registerAccount
    Completer completer = new Completer();
    http.post("${Common.rootUrlApi}register", body: data).then((value) {
      completer.complete(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future createShop(data) {
    // TODO: implement createShop
    Completer completer = new Completer();
    http.post("${Common.rootUrlApi}shop/createshop",
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(data));
    return completer.future;
  }

  @override
  Future updateMerchandise(data) {
    // TODO: implement updateMerchandise
    Completer completer = new Completer();
    http.post("${Common.rootUrlApi}merchandise/updatemerchandise",
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
          HttpHeaders.contentTypeHeader: 'application/json'
        });
    return completer.future;
  }
}
