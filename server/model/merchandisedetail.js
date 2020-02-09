var pool = require("../controller/config");
function getListMerchandise(params) {
    console.log("id cua hang " , params);
    
    return  new Promise((reslove, reject)=>{
        var sql = "SELECT * FROM merchandisedetail WHERE " +params["key"]+" = " + params["value"];
        console.log(sql);
        
        pool.query(sql,[params["key"], params["value"]],(err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else {
                reslove(rows);
            }
        });
    });
}
function createMerchandis(params) {
    console.log("paramas ===========",params)
    return new Promise((reslove, reject)=>{
        var sql = "INSERT INTO merchandisedetail (barcode, image, idShop, nameMerchandise, idCategory, inputPrice, outputPrice, count, unit) VALUES (?,?,?,?,?,?,?,?,?)"
        pool.query(sql,[
            params["barcode"],
            params["image"],
            params["idShop"],
            params["nameMerchandise"],
            params["idCategory"],
            params["inputPrice"],
            params["outputPrice"],
            params["count"],
            params["unit"],
    ],(err, rows)=>{
        if(err) {
            throw err,
            reject(err);
        }
        else {
            console.log(
            "1234567890",rows);
            reslove(rows);
        }
    });    
})}
module.exports={
    getListMerchandise:getListMerchandise,
    createMerchandis:createMerchandis,
}