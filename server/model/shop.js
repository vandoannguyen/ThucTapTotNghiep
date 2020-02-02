var pool = require("../controller/config");
function getListShop(value) {
    var sql = "SELECT * FROM shop where idShopkepper=?";
   return new Promise((reslove, reject)=>{ pool.query("SELECT * FROM shop where idShopkepper=?",[value],(err, rows)=>{
        if (err) {
            reject(err);
            throw err;
        }
        else reslove(rows)
    });});
}
function createShop(value) {
    return new Promise((reslove, reject)=>{
        var date = new Date();
        var curentDateTime = date.toISOString().slice(0, 19).replace('T', ' ')
        pool.query("INSERT INTO shop( name, address, idShopkepper, image, dateCreate) VALUES (?,?,?,?,?)",
        [value["name"], 
        value["address"], 
        value["idShopkepper"], 
        value["image"],
        curentDateTime],
        (err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}
function updateShop(params) {
    return new Promise((reslove, reject)=>{
        pool.query("UPDATE shop SET name=?,address=?,idShopkepper=?,image=? WHERE idShop=?",
        [params["name"], 
        params["address"], 
        params["idShopkepper"], 
        params["image"]],
        (err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}
function deleteShop(id) {
    return new Promise((reslove, reject)=>{
        pool.query("DELETE FROM shop WHERE idShop=?",[id],(err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}

module.exports={
    createShop:createShop,
    getListShop:getListShop,
    updateShop:updateShop,
}