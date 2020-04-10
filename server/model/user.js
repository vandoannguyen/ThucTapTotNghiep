var pool = require("../controller/config");
const Cryptr = require('cryptr');
const cryptr = new Cryptr('myTotalySecretKey');
function getUser(username, callback) {
       return new Promise((reslove, reject)=>{
        pool.query("select * from user where username = '"+ username +"'", (err, rows)=>{
            if(err) reject(err);
            else reslove(rows)
        });
       } );
}
function getUserById(idUser){
    return new Promise((reslove, reject)=>{
        console.log("idUser", idUser);
        pool.query("select * from user where idUser = '"+ idUser +"'", (err, rows)=>{
            if(err) reject(err);
            else reslove(rows)
        });
    })
}
function createUser(params) {
    return new Promise((reslove, reject)=>{
        var date  = new Date();
        console.log(params);
        pool.query("INSERT INTO user (name, username, email, password,idRole, image, createDate) values(?,?,?,?,?,?,?)",[
            params["name"] ,
            params["username"],
            params["email"] ,
        cryptr.encrypt(params["password"]), params["role"] , params["image"],
        date.toISOString().slice(0, 19).replace('T', ' ')],(err, rows)=>{
            if(err){
                console.log(err);
                reject(err);
                throw err;
            }
            else reslove(rows);
        });
    })
}
function updateUser(params) {
    return new Promise((reslove, reject)=>{
        var date  = new Date();
        pool.query("UPDATE user SET name=?,username=?,email=?,password=?,image=? WHERE idUser=?",[
            params["name"] ,
            params["username"],
            params["email"] ,
        cryptr.encrypt(params["password"]),params["image"]],(err, rows)=>{
            if(err){
                reject(err);
                throw err;
            }
            else reslove(rows);
        });
    })
}
function deleteUser(id) {
    return new Promise((reslove, reject)=>{
        var date  = new Date();
        pool.query("DELETE FROM user WHERE idUser=?",[id],(err, rows)=>{
            if(err){
                reject(err);
                throw err;
            }
            else reslove(rows);
        });
    })
}
function changePass(value){
    return new Promise((reslove, reject)=>{
        pool.query("UPDATE user SET password=? WHERE idUser=?", [cryptr.encrypt(value["password"]), value["idUser"]], (err, rows)=>{
            if(err){
                console.log(err);
                reject(err);
            }
            else reslove(rows);
            console.log(rows);
        });
    });
}
module.exports={
    getUser:getUser,
    createUser:createUser,
    updateUser:updateUser,
    deleteUser:deleteUser,
    changePass:changePass,
    getUserById:getUserById,
}