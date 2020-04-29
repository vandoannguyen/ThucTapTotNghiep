var pool = require("../controller/config");
function insertCategory(params) {
    return new Promise((reslove, reject)=>{
        pool.query("INSERT INTO category( idShop, nameCategory) VALUES (?,?)",
        [params["idShop"], 
        params["nameCategory"]],
        (err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}
function updateCategory(params) {
    return new Promise((reslove, reject)=>{
        pool.query("UPDATE category SET nameCategory=? WHERE  idCategory=?",
        [params["nameCategory"], 
        params["idCategory"]],
        (err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}
function deleteCategory(id, idNoCategory, idShop) {
    return new Promise((reslove, reject)=>{
        pool.query("CALL deleteCategory(?,?,?)",
        [id, idNoCategory, idShop],
        (err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}
function getListCategory(idShop) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM category WHERE idShop=? ORDER BY idCategory DESC",
        [idShop],
        (err, rows)=>{
            if(err)
            reject(err);
            else reslove(rows);
        });
    })
}
module.exports={
    insertCategory:insertCategory,
    updateCategory:updateCategory,
    getListCategory:getListCategory,
    deleteCategory:deleteCategory,
}