var con = require("./config");
const Cryptr = require('cryptr');
const cryptr = new Cryptr('myTotalySecretKey');
var jwt = require("jsonwebtoken");
var userModel = require("../model/user");
var shopModel = require("../model/shop");
var base64ToImage = require('base64-to-image');


async function createUser(req, res) {
    if (req.body["image"] != "") {
        var path = './public';
        var optionalObj = { 'fileName': "image" + Date.now(), 'type': 'png' };
        var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
        var imageName = "/upload/" + "image" + Date.now() + ".png";
        require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
            if (err) res.json({ status: 500, message: err })
            else {
                req.body["image"] = imageName;
                  userModel.createUser(req.body).then((value) => {
            res.json({
                message: "Create user success",
                success: true,
            })
        }).catch((err) => {
            res.json({
                message: "Can not create user " + err,
                success: false
            })
        })
            }
        });
        // var imageInfo = base64ToImage(req.body["image"].toString(), path, optionalObj);
        // console.log(imageInfo);

        // Note base64ToImage function returns imageInfo which is an object with imageType and fileName.

        // req.body["image"] = i
        // userModel.createUser(req.body).then((value) => {
        //     res.json({
        //         message: "Create user success",
        //         success: true,
        //     })
        // }).catch((err) => {
        //     res.json({
        //         message: "Can not create user " + err,
        //         success: false
        //     })
        // })
    }
    else
        userModel.createUser(req.body).then((value) => {
            res.json({
                message: "Create user success",
                success: true,
            })
        }).catch((err) => {
            res.json({
                message: "Can not create user " + err,
                success: false
            })
        })
}
async function userLogin(req, res) {
    var result = await userModel.getUser(req.body["username"])
    console.log(result);

    if (result) {
        if (cryptr.decrypt(result[0]["password"]) === req.body["password"]) {
            var shops = null;
            if (result[0]["idRole"] == 4)
                shops = await shopModel.getListShop(result[0]["idUser"]);
            var token = jwt.sign(req.body, 'token', { expiresIn: "3h" });
            res.status(200);
            result[0]["password"] = '';
            res.json({ 'token': token, "user": result[0], "shop": shops });
        }

    }
}
module.exports = {
    userLogin: userLogin,
    createUser: createUser,
}