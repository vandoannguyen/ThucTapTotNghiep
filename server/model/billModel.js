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
        pool.query("INSERT INTO bill(name, idSeller, dateCreate, discount, idShop) VALUES (?,?,?,?,?)",
         [value["name"],value["idSeller"],date.toISOString().slice(0, 19).replace('T', ' '),value["discount"],value["idShop"]], (err, rows)=>{
            if(err){
                reject(err);
                throw(err)
            }
            else reslove(rows);
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