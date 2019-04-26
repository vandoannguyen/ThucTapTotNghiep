var pool = require("../controller/config");
const Cryptr = require('cryptr');
const cryptr = new Cryptr('myTotalySecretKey');
function getUser(username) {
    return new Promise((reslove, reject) => {
        pool.query("select * from user where username = '" + username + "'", (err, rows) => {
            if (err) reject(err);
            else reslove(rows)
        });
    });
}
function getUserById(idUser) {
    return new Promise((reslove, reject) => {
        console.log("idUser", idUser);
        pool.query("select * from user where idUser = '" + idUser + "'", (err, rows) => {
            if (err) reject(err);
            else reslove(rows)
        });
    })
}
function createUser(params) {
    return new Promise((reslove, reject) => {
        var date = new Date();
        console.log(params);
        pool.query("INSERT INTO user (name, username, email, password,idRole, image, createDate) values(?,?,?,?,?,?,?)", [
            params["name"],
            params["username"],
            params["email"],
            cryptr.encrypt(params["password"]), params["role"], params["image"],
            date.toISOString().slice(0, 19).replace('T', ' ')], (err, rows) => {
                if (err) {
                    console.log(err);
                    reject(err);
                    // throw err;
                }
                else reslove(rows);
            });
    })
}
function updateUser(params) {
    return new Promise((reslove, reject) => {
        var date = new Date();
        pool.query("UPDATE user SET name=?,username=?,email=?,password=?,image=? WHERE idUser=?", [
            params["name"],
            params["username"],
            params["email"],
            cryptr.encrypt(params["password"]), params["image"], params["idUser"]], (err, rows) => {
                if (err) {
                    reject(err);
                    // throw err;
                }
                else{
                    reslove(rows);
                    console.log(params);
                    console.log(rows);
                };
            });
    })
}
function deleteUser(id) {
    return new Promise((reslove, reject) => {
        var date = new Date();
        pool.query("DELETE FROM user WHERE idUser=?", [id], (err, rows) => {
            if (err) {
                reject(err);
                throw err;
            }
            else reslove(rows);
        });
    })
}
function changePass(value) {
    return new Promise((reslove, reject) => {
        pool.query("UPDATE user SET password=? WHERE idUser=?", [cryptr.encrypt(value["password"]), value["idUser"]], (err, rows) => {
            if (err) {
                console.log(err);
                reject(err);
            }
            else reslove(rows);
            console.log(rows);
        });
    });
}
function createPersonnel(params) {
    return new Promise((reslove, reject) => {
        var date = new Date();
        console.log(params);
        pool.query("INSERT INTO personnel (idPersonnel,idShop,status) values(?,?,?)", [
            params["idUser"],
            params["idShop"],
            params["status"]], (err, rows) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                else reslove(rows);
            });
    })
}
function getpersonnels(idShop) {
    return new Promise((reslove, reject) => {
        pool.query("SELECT name, image, username, password, email, createDate, idRole,idPersonnel, idShop, status FROM personnel, user WHERE idShop= ? AND idUser=idPersonnel ",
            [idShop], (err, rows) => {
                if (err) reject(err);
                else {
                    rows = rows.map((element) => {
                        element["password"] = cryptr.decrypt(element["password"]);
                        return element;
                    });
                    reslove(rows)
                }
            }
        )
    })
}
function getPersonnel(idUser) {
    return new Promise((reslove, reject) => {
        pool.query("SELECT * FROM personnel WHERE idPersonnel=?",
            [idUser], (err, rows) => {
                if (err) reject(err);
                else reslove(rows[0])
            }
        )
    })
}
function createPersonnel(params) {
    return new Promise((reslove, reject) => {
        pool.query("INSERT INTO personnel(idPersonnel, idShop, status) VALUES (?,?,?)", [params["idUser"], params["idShop"], 1], (err, rows) => {
            if (err)
                reject(err);
            else
                reslove(rows);
        })
    })
}
function deletePersonnel(idUser){
    return new Promise((reslove, reject)=>{
        pool.query("UPDATE personnel SET status=0 WHERE idPersonnel=?", [idUser],(err, rows)=>{
            if(err) reject(err);
            else reslove(rows);
        })
    });
}
module.exports = {
    getUser: getUser,
    createUser: createUser,
    updateUser: updateUser,
    deleteUser: deleteUser,
    changePass: changePass,
    getUserById: getUserById,
    getpersonnels: getpersonnels,
    createPersonnel: createPersonnel,
    getPersonnel: getPersonnel,
    deletePersonnel:deletePersonnel,
}