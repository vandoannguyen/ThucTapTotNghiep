var pool = require("../controller/config");
function getListMerchandise(idCuaHang) {
    return  new Promise((reslove, reject)=>{
        var sql = "SELECT * FROM merchandisedetail WHERE idShop = ?";
        pool.query(sql,idCuaHang,(err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else reslove(rows);
        });
    });
}
module.exports={
    getListMerchandise:getListMerchandise,
}