var pool = require("../controller/config");
function getListBill(idShop) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM bill WHERE idShop = ?", [idShop], (err, rows)=>{
            if(err){
                reject(err);
                throw(err)
            }
            else reslove(rows);
        })
    })
}
function getBill(id) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM bill WHERE idBill = ?", [id], (err, rows)=>{
            if(err){
                reject(err);
                throw(err)
            }
            else reslove(rows[0]);
        })
    })
}
function insertBill(value) {
    return new Promise((reslove, reject)=>{
        var date  = new Date();
        pool.query("INSERT INTO bill( name, status, totalPrice, idSeller, dateCreate, discount, idShop, description) VALUES(?,?,?,?,?,?,?,?)",
         [value["name"],
         value["status"],
         value["totalPrice"],
         value["idSeller"],
         date.toISOString().slice(0, 19).replace('T', ' '),
         value["discount"],
         value["idShop"],
         value["description"],
        ], (err, rows)=>{
            if(err){
                reject(err);
                throw(err)
            }
            else {
                pool.query("Select idBill from bill where idSeller= ? ORDER BY idBill DESC LIMIT 1", [value["idSeller"]],(err, rows)=>{
                    if(err){
                        reject(err);
                        throw err
                    }
                    else{
                        if(rows.length>0)
                        {
                            pool.query("INSERT INTO ref_bill_merchandise VALUES ?",
                            value["listMer"].map((element)=>{
                                return [rows[0], element["idShop"], element["countsp"]];
                            }).toList, (err, rows)=>{
                                if(err)
                                {
                                    throw "lỗi insert ref " +  err;
                                    reject (err);
                                }
                                // chưa update bảng detail
                                // else  
                            }
                            )
                        }
                    }
                } )
            }
        })
    })
}
function updateBill(value) {
    return new Promise((reslove, reject)=>{
        pool.query("UPDATE bill SET name=?,idSeller=?,discount=?,idShop=? WHERE idBill= ?",
         [value["name"],value["idSeller"],value["discount"],value["idShop"],value["idBill"]], (err, rows)=>{
            if(err){
                reject(err);
                throw(err)
            }
            else reslove(rows);
        })
    })
}
function deleteBill(id) {
    return new Promise((reslove, reject)=>{
        var date  = new Date();
        pool.query("DELETE FROM bill WHERE idBill= ?",
         [id], (err, rows)=>{
            if(err){
                reject(err);
                throw(err)
            }
            else reslove(rows);
        })
    })
}
module.exports={
    getListBill:getListBill,
    getBill:getBill,
    insertBill:insertBill,
    updateBill:updateBill,
    deleteBill:deleteBill
}