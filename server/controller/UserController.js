var con = require("./config");
const Cryptr = require('cryptr');
const cryptr = new Cryptr('myTotalySecretKey');
var jwt = require("jsonwebtoken");
var userModel = require("../model/user");
var shopModel = require("../model/shop");
async function createUser(req, res){
    userModel.createUser(req.body).then((value)=>{
        res.json({
            message:"Create user success",
            success:true,
        })
    }).catch((err)=>{
        res.json({
            message:"Can not create user " + err,
            success:false
        })
    })
}
async function userLogin (req, res)  {
  var result = await  userModel.getUser(req.body["username"])
    console.log(result);
    
    if(result){
            if(cryptr.decrypt(result[0]["password"]) === req.body["password"])
            {
                var shops = null;
                if(result[0]["idRole"] == 4)
                shops = await shopModel.getListShop(result[0]["idUser"]);
                var token = jwt.sign(req.body, 'token',{expiresIn:"3h"});
                res.status(200);
                result[0]["password"] = '';
            res.json({'token':token, "user":result[0], "shop":shops});
            }
    
    }
}
module.exports = {
    userLogin : userLogin,
    createUser : createUser,
}