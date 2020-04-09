var pool = require("../controller/config");
function getListMerchandise(params) {
    console.log("id cua hang ", params);

    return new Promise((reslove, reject) => {
        var sql = "SELECT * FROM merchandisedetail WHERE " + params["key"] + " = " + params["value"];
        console.log(sql);
        pool.query(sql, [params["key"], params["value"]], (err, rows) => {
            if (err) {
                reject(err);
                throw err;
            }
            else {
                reslove(rows);
            }
        });
    });
}
async function getListMerchandiseByBill(params) {
    console.log("id cua hang ", params);

    return new Promise((reslove, reject) => {
        var sql = "SELECT idBill, refbillmerchandise.barcode, refbillmerchandise.count as countsp, image,outputPrice, nameMerchandise FROM refbillmerchandise, merchandisedetail WHERE refbillmerchandise.barcode = merchandisedetail.barcode AND idBill =? AND idShop=?";
        console.log(sql);
        pool.query(sql, [params["idBill"], params["idShop"]], (err, rows) => {
            if (err) {
                reject(err);
                throw err;
            }
            else {
                reslove(rows);
            }
        });
    });
}
function createMerchandise(params) {
    console.log("paramas ===========", params)
    return new Promise((reslove, reject) => {
        var sql = "INSERT INTO merchandisedetail (barcode, image, idShop, nameMerchandise, idCategory, inputPrice, outputPrice, count) VALUES (?,?,?,?,?,?,?,?)"
        try{
            pool.query(sql, [
                params["barcode"],
                params["image"],
                params["idShop"],
                params["nameMerchandise"],
                params["idCategory"],
                params["inputPrice"],
                params["outputPrice"],
                params["count"],
            ], (err, rows) => {
                if (err) {
                    console.log(err);
                    throw err,
                    reject(err);
                }
                else {
                    console.log(
                        "1234567890", rows);
                    reslove(params);
                }
            });
        }
        catch(err){
            reject(err);
        }
    })
}
async function getBestSeller(params) {
    console.log(params);
    return new Promise(
        (reslove, reject) => {
            var query = "CALL getTopBestSeller(?,?,?,?)";
            pool.query(query, [params["idShop"], params["limits"], params["fromDate"], params["toDate"]], (err, rows) => {
                if (err) {
                    reject(err);
                    throw err;
                }
                else {
                    console.log(rows[0]);
                    reslove(rows[0]);
                }
            })
        }
    );
}
async function getMerchandiseWillEmpty(params) {
    return new Promise((reslove, reject) => {
        console.log(params["warningCount"] + "    " +  params["idShop"] + "okok");
        
        var query =
            "Select idShop, barcode, nameMerchandise, count as countsp, image FROM merchandisedetail where count <= ? and idShop = ?";
        pool.query(query, [params["warningCount"], params["idShop"]], (err, rows) => {
            if (err) {
                reject(err);
                throw err;
            }
            else {
                console.log("1234567890 will empty");
                console.log(rows); reslove(rows);
            }
        })

    })
}
async function updateMerchandises(params) {
    return new Promise((reslove, reject) => {
        var sql = "UPDATE merchandisedetail SET count=?,idCategory=?,image=?,inputPrice=?,nameMerchandise=?,outputPrice=? WHERE barcode=? AND idShop=?";
        pool.query(sql, [
            params["count"],
            params["idCategory"],
            params["image"],
            params["inputPrice"],
            params["nameMerchandise"],
            params["outputPrice"],
            params["barcode"],
            params["idShop"],
        ], (err, rows) => { 
            if (err) {
                reject(err);
                throw err;
            }
            else { console.log(rows); reslove(rows); }
        })
    })

}
module.exports = {
    getListMerchandise: getListMerchandise,
    createMerchandise: createMerchandise,
    getListMerchandiseByBill: getListMerchandiseByBill,
    getBestSeller: getBestSeller,
    getMerchandiseWillEmpty: getMerchandiseWillEmpty,
    updateMerchandises: updateMerchandises,
}