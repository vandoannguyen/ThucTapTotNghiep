var pool = require("../controller/config");
function getListShop(value) {
    console.log(value);

    var sql = "SELECT * FROM shop where idShopkepper=?";
    return new Promise((reslove, reject) => {
        console.log(value);

        pool.query("SELECT * FROM shop where idShopkepper=?", [value], (err, rows) => {
            if (err) {
                reject(err);
                throw err;
            }
            else reslove(rows)
        });
    });
}
function createShop(value) {
    var warningCount = value["warningCount"];
    if (warningCount == null || warningCount == 0)
        warningCount = 10;
    return new Promise((reslove, reject) => {
        var date = new Date();
        var curentDateTime = date.toISOString().slice(0, 19).replace('T', ' ')
        pool.query("INSERT INTO shop( name, address, idShopkepper, image, dateCreate, phoneNumber, description, warningCount) VALUES (?,?,?,?,?,?,?,?)",
            [value["name"],
            value["address"],
            value["idShopkepper"],
            value["image"],
                curentDateTime, value["phoneNumber"], value["description"], warningCount],
            (err, rows) => {
                if (err)
                    reject(err);
                else reslove(rows);
            });
    })
}
function updateShop(params) {
    return new Promise((reslove, reject) => {
        pool.query("UPDATE shop SET name=?,address=?,idShopkepper=?,image=? WHERE idShop=?",
            [params["name"],
            params["address"],
            params["idShopkepper"],
            params["image"]],
            (err, rows) => {
                if (err)
                    reject(err);
                else reslove(rows);
            });
    })
}
function deleteShop(id) {
    return new Promise((reslove, reject) => {
        pool.query("DELETE FROM shop WHERE idShop=?", [id], (err, rows) => {
            if (err)
                reject(err);
            else reslove(rows);
        });
    })
}

module.exports = {
    createShop: createShop,
    getListShop: getListShop,
    updateShop: updateShop,
}