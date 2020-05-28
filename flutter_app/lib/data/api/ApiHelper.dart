import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:init_app/common/Common.dart';
import 'package:init_app/data/api/IApiHelper.dart';

class ApiHelper implements IApiHelper {
  static dynamic _getHeader() {
    return {
      HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
      HttpHeaders.contentTypeHeader: 'application/json'
    };
  }

  @override
  Future postLogin(user) {
    // TODO: implement postLogin
    Completer completer = new Completer();
    http.post("${Common.rootUrlApi}login", body: user).then((value) {
      completer.complete(jsonDecode(value.body));
    }).catchError((error) {
      print("32s1df32s1d3f21sd32f1");
      print("error${error}");
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
  Future getBillByDay(idShop, startDate, endDate, status) {
    Completer com = new Completer();
    var now = new DateTime.now();
    print(now.toIso8601String());
    http
        .post("${Common.rootUrlApi}bill/getBills",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode({
              "user": Common.user,
              "startDate": startDate.toIso8601String().replaceFirst("T", " "),
              "endDate": endDate.toIso8601String().replaceFirst("T", " "),
              "status": status,
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
      completer.complete(jsonDecode(value.body));
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
      "${Common.rootUrlApi}merchandise/listMerchandis?idShop=${idShop}",
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
      print(value.body);
      if (value.statusCode == 200) {
        completer.complete("Thêm sản phẩm thành công");
      }
      if (value.statusCode == 400) {
        if (value.body.contains("ER_DUP_ENTRY"))
          completer.completeError("Sản phẩm đã có trong cửa hàng");
        else {
          print(value.body);
          completer.completeError(value.body);
        }
      }
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
      if (value.statusCode == 200) {
        completer.complete(jsonDecode(value.body));
      } else {
        completer.completeError(jsonDecode(value.body));
      }
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future registerAccount(data) {
    // TODO: implement registerAccount
    Completer completer = new Completer();
    http.post("${Common.rootUrlApi}register",
        body: data,
        headers: {'content-type': 'application/json'}).then((value) {
      print(value.statusCode);
      if (value.statusCode == 400) {
        completer.completeError(jsonDecode(value.body)["error"]);
      } else
        completer.complete(jsonDecode(value.body));
    }).catchError((err) {
      print("err${err}");
      completer.completeError("err");
    });
    return completer.future;
  }

  @override
  Future createShop(data) {
    // TODO: implement createShop
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}shop/createshop",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete("Thêm cửa hàng thàng công");
      } else {
        completer.completeError("Thêm cửa hàng không thành công");
      }
    }).catchError((err) {
      completer.completeError("Thêm cửa hàng không thành công");
    });
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
        }).then((value) {
      completer.complete(value);
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future getBestSeller(idShop, limits, fromDate, toDate) {
    // TODO: implement getBestSeller
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}merchandise/getbestseller",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode({
              "idShop": idShop,
              "limits": limits,
              "fromDate": fromDate,
              "toDate": toDate
            }))
        .then((value) {
      print("body ${value.body}");
      completer.complete(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future getWillBeEmpty(idShop, warningCount) {
    // TODO: implement getWillBeEmpty
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}merchandise/getMerchandisewillempty",
            headers: _getHeader(),
            body: jsonEncode({"idShop": idShop, "warningCount": warningCount}))
        .then((onValue) {
      completer.complete(jsonDecode(onValue.body));
    }).catchError((onError) {
      completer.completeError(onError);
    });
    return completer.future;
  }

  @override
  Future getPersonnelByBill(idPersonnel) {
    // TODO: implement getPersonnelByBill

    Completer completer = new Completer();
    http
        .get("${Common.rootUrlApi}users/user?idUser=${idPersonnel}",
            headers: _getHeader())
        .then((value) {
      completer.complete(jsonDecode(value.body)[0]);
    }).catchError((err) {
      completer.completeError(err);
      print(err);
    });
    return completer.future;
  }

  @override
  Future createPersonnel(data) {
    // TODO: implement createPersonnel
    print(data);
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}users/createpersonnel",
            body: data, headers: _getHeader())
        .then((value) {
      if (value.statusCode == 200) completer.complete(jsonDecode(value.body));
      if (value.statusCode == 400) {
        completer.completeError(jsonDecode(value.body)["error"]);
      }
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future getPersonnels(idShop) {
    // TODO: implement getPersonnels
    Completer completer = new Completer();
    http
        .get("${Common.rootUrlApi}users/getpersonnels?idShop=$idShop",
            headers: _getHeader())
        .then((value) {
      if (value.statusCode == 200) completer.complete(jsonDecode(value.body));
      if (value.statusCode == 400) {
        print("error load data");
      }
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future updateUser(user) {
    // TODO: implement updateUser
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}users/updateUser",
            headers: _getHeader(), body: user)
        .then((value) {
      print(value.body);
      if (value.statusCode == 200)
        completer.complete(jsonDecode(value.body));
      else
        completer.completeError(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
      print(err);
    });
    return completer.future;
  }

  @override
  Future deletePersonnel(idUser) {
    // TODO: implement deletePersonnel
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}users/deletePersonnel",
            headers: _getHeader(), body: jsonEncode({"idUser": idUser}))
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete("Xóa nhân viên thành công");
      } else {
        completer.completeError("Xóa nhân viên không thành công!");
      }
    }).catchError((onError) {
      completer.completeError(onError);
    });
    return completer.future;
  }

  @override
  Future updateShop(data) {
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}shop/updateShop",
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + Common.loginToken,
              HttpHeaders.contentTypeHeader: 'application/json'
            },
            body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete("Cập nhật thông tin thành công");
      }
      if (value.statusCode == 400) {
        completer.completeError("Cập nhật thông tin không thành công!");
      }
    }).catchError((err) {
      completer.completeError("Cập nhật thông tin không thành công!");
      print(err);
    });
    return completer.future;
  }

  @override
  Future deleteMerchandise(barcode, idShop) {
    // TODO: implement deleteMerchandise
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}merchandise/deleteMerchandise",
            body: jsonEncode({
              "barcode": barcode,
              "idShop": idShop,
            }),
            headers: _getHeader())
        .then((value) {
      print(value.body);
      if (value.statusCode == 200) completer.complete("Xóa thành công");
      print(value.statusCode);
    }).catchError((err) {
      completer.completeError("Xóa không thành công!");
    });
    return completer.future;
  }

  @override
  Future deleteCategory(idCategory, idNoCategory, idShop) {
    // TODO: implement deleteCategory
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}category/delete",
            body: jsonEncode({
              "idCategory": idCategory,
              "idNoCategory": idNoCategory,
              "idShop": idShop
            }),
            headers: _getHeader())
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete(jsonDecode(value.body));
      } else
        completer.completeError(jsonDecode(value.body));
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }

  @override
  Future deleteShop(idShop) {
    // TODO: implement deleteShop
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}shop/deleteShop",
            body: jsonEncode({"idShop": idShop}), headers: _getHeader())
        .then((value) {
      if (value.statusCode == 200) {
        print("Xóa THành công");
        completer.complete("Xóa thành cửa hàng thành công.");
      } else {
        completer.completeError("Xóa không thành công");
      }
    }).catchError((err) {
      print(err);
      completer.completeError("Xóa không thành công");
    });
    return completer.future;
  }

  @override
  Future sendEmail(
      {shopName, merchandiseName, count, phoneNumber, address, barcode}) {
    Completer completer = new Completer();
    // TODO: implement sendEmail
    var body = {
      "shopName": shopName,
      "merchandiseName": merchandiseName,
      "count": count,
      "phoneNumber": phoneNumber,
      "address": address,
      "barcode": barcode,
    };
    return http
        .post("${Common.rootUrlApi}email/send",
            headers: _getHeader(), body: jsonEncode(body))
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete();
      } else {
        completer.completeError(value.body);
      }
    }).catchError((err) {
      completer.completeError(err);
    });
  }

  @override
  Future updateCategory(idCategory, name) {
    // TODO: implement updateCategory
    Completer completer = new Completer();
    var data = {"idCategory": idCategory, "nameCategory": name};
    http
        .post("${Common.rootUrlApi}category/update",
            headers: _getHeader(), body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete(value.body);
      } else {
        completer.completeError({"success": false});
      }
    }).catchError((onError) => {completer.completeError(onError)});
    return completer.future;
  }

  @override
  Future getListShop(idUser) {
    // TODO: implement getListShop
    Completer completer = new Completer();
    http
        .post("${Common.rootUrlApi}shop/listShop",
            headers: _getHeader(), body: jsonEncode({"idUser": idUser}))
        .then((value) {
      if (value.statusCode == 200) {
        completer.complete(jsonDecode(value.body));
      } else
        completer.completeError("can`t not load list shop");
    }).catchError((err) {
      completer.completeError(err);
    });
    return completer.future;
  }
}
