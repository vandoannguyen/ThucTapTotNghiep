var pool = require("../controller/config");
function getListBill(idShop) {
    return new Promise((reslove, reject) => {
        pool.query("SELECT * FROM bill WHERE idShop = ? ORDER BY dateCreate DESC", [idShop], (err, rows) => {
            if (err) {
                reject(err);
                throw (err)
            }
            else reslove(rows);
        })
    })
}
function getBill(id) {
    return new Promise((reslove, reject) => {
        pool.query("SELECT * FROM bill WHERE idBill = ?", [id], (err, rows) => {
            if (err) {
                reject(err);
                throw (err)
            }
            else reslove(rows[0]);
        })
    })
}
function insertBill(value) {
    console.log(value);
    console.log(value["listMer"].map((element) => {
        return [1, element["idShop"], element["countsp"]];
    }));
    return new Promise((reslove, reject) => {
        let date = new Date();

        pool.query("INSERT INTO bill( name, status, totalPrice, idSeller, dateCreate, discount, idShop, description) VALUES(?,?,?,?,?,?,?,?)",
            [value["name"],
            value["status"],
            value["totalPrice"],
            value["idSeller"],
            value["dateCreate"],
            value["discount"],
            value["idShop"],
            value["description"],
            ], (err, rows) => {
                if (err) {
                    reject(err);
                    throw (err)
                }
                else {
                    pool.query("Select idBill, status from bill where idSeller= ? ORDER BY idBill DESC LIMIT 1", [value["idSeller"]], (err, rows) => {
                        if (err) {
                            reject(err);
                            throw err
                        }
                        else {
                            if (rows.length > 0)
                                // {
                                //    console.log( value["listMer"].map((element)=>{
                                //     return [rows[0]["idBill"], element["idShop"], element["countsp"]];
                                // }));
                                console.log(rows[0]);
                            value["listMer"].forEach(element => {
                                pool.query("INSERT INTO refbillmerchandise(idBill, barcode, count, status) VALUES (?,?,?,?) ",

                                    [rows[0]["idBill"], element["barcode"], element["countsp"], rows[0]["status"]], (err, rows) => {
                                        if (err) {
                                            throw "lỗi insert ref " + err;
                                            reject(err);
                                        }
                                        // chưa update bảng detail
                                        else {
                                            reslove(rows);
                                        }
                                    }
                                )
                            });
                        }
                    })
                }
            })
    })
}
function updateBill(value) {
    return new Promise((reslove, reject) => {
        pool.query("UPDATE bill SET name=?,idSeller=?,discount=?,idShop=? WHERE idBill= ?",
            [value["name"], value["idSeller"], value["discount"], value["idShop"], value["idBill"]], (err, rows) => {
                if (err) {
                    reject(err);
                    throw (err)
                }
                else reslove(rows);
            })
    })
}
function deleteBill(id) {
    return new Promise((reslove, reject) => {
        var date = new Date();
        pool.query("DELETE FROM bill WHERE idBill= ?",
            [id], (err, rows) => {
                if (err) {
                    reject(err);
                    throw (err)
                }
                else reslove(rows);
            })
    })
}
function getBills(data) {
    // var date = new Date(data["date"])
    var start = data["startDate"];
    var end = data["endDate"];
    var statDate = start.slice(0, 10);
    statDate += " 00:00:00"
    var endDate = end.slice(0, 10);
    endDate += " 23:59:59"
    // var endDate = date.toString();
    console.log(statDate + "\n" + endDate);
    var status = data["status"];
    console.log(status);

    return new Promise((reslove, reject) => {
        if (data["user"]["idRole"] == 2) {
            var query = "SELECT * FROM bill WHERE dateCreate BETWEEN ? AND ? And idShop=? ";
            if (status == 0 || status == 1)
                query += ("AND status=" + status + " ");
            pool.query(query, [statDate, endDate, data["idShop"]], (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                    throw err;
                }
                else {
                    console.log(result);
                    reslove(result);
                }
            });
        }
        if (data["user"]["idRole"] == 1) {
            var query = "SELECT * FROM bill WHERE dateCreate BETWEEN ? AND ? And idShop=? AND idSeller=? ";
            if (status == 0 || status == 1)
                query += ("AND status=" + status + " ");
            pool.query(query, [statDate, endDate, data["idShop"], data["user"]["idUser"]], (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                else {
                    console.log(result);
                    reslove(result);
                }
            });
        }
    });
}
function getCurrentBills(data) {
    var date = new Date(data["date"])
    var statDate = date.toISOString().slice(0, 10);
    statDate += " 00:00:00"
    var endDate = date.toISOString().slice(0, 10);
    endDate += " 23:59:59"
    // var endDate = date.toString();
    console.log(statDate + "\n" + endDate);

    return new Promise((reslove, reject) => {
        if (data["user"]["idRole"] == 2) {
            try{
                pool.query("SELECT * FROM bill WHERE dateCreate BETWEEN ? AND ? And idShop=? AND status=0", [statDate, endDate, data["idShop"]], (err, result) => {
                    if (err) {
                        console.log(err);
                        throw err;
                        reject(err);
                    }
                    else {
                        console.log(result);
                        reslove(result);
                    }
                });
            }
            catch(err){
                reject(err)
            }
        }
    });
}
module.exports = {
    getListBill: getListBill,
    getBill: getBill,
    insertBill: insertBill,
    updateBill: updateBill,
    deleteBill: deleteBill,
    getCurrentBills: getCurrentBills,
    getBills: getBills
}