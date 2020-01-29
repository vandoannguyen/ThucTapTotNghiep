var con = require("./config");
const Cryptr = require('cryptr');
const cryptr = new Cryptr('myTotalySecretKey');
var jwt = require("jsonwebtoken");
var userModel = require("../model/user");
async function createUser(req, res){
            var date  = new Date();
            con.query("INSERT INTO user (name, username, email, password, createDate) values(?,?,?,?,?)",[
            req.body["name"] ,
            req.body["username"],
            req.body["email"] + "','"+
            cryptr.encrypt(req.body["password"]),
            date.toISOString().slice(0, 19).replace('T', ' ')],(err, rows)=>{
                console.log(rows);
            });
}
async function userLogin (req, res)  {
    userModel.getUser(req.body["username"]).then((value)=>{
        if(cryptr.decrypt(value[0]["password"]) === req.body["password"])
        {
            var token = jwt.sign(req.body, 'token',{expiresIn:"3h"});
            res.status(200);
        res.json(token);
        }

    }).catch((value)=>{
        res.status(401);
        res.json({success:false, 
            message:"cant not get user"});
    });
}
module.exports = {
    userLogin : userLogin,
    createUser : createUser,
}