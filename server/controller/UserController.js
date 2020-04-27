var con = require("./config");
const Cryptr = require('cryptr');
const cryptr = new Cryptr('myTotalySecretKey');
var jwt = require("jsonwebtoken");
var userModel = require("../model/user");
var shopModel = require("../model/shop");
var base64ToImage = require('base64-to-image');


async function createUser(req, res) {
    if (req.body["image"] != null && req.body["image"] != "") {
        var path = './public';
        var optionalObj = { 'fileName': "image" + Date.now(), 'type': 'png' };
        var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
        var imageName = "/upload/" + "image" + Date.now() + ".png";
        require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
            if (err) res.json({ status: 500, message: err })
            else {
                req.body["image"] = imageName;
                userModel.createUser(req.body).then((value) => {
                    res.status(200).json({
                        message: "Create user success",
                        success: true,
                    })
                }).catch((err) => {
                    res.status(400).json({
                        error: "Username đã tồn tại"
                    })
                })
            }
        });
    }
    else
        req.body["image"] = "";
    userModel.createUser(req.body).then((value) => {
        res.json({
            message: "Create user success",
            success: true,
        })
    }).catch((err) => {
        res.status(400).json({
            error: "Username đã tồn tại"
        })
    })
}
async function userLogin(req, res) {

    var result = await userModel.getUser(req.body["username"])
    if (result.length > 0) {
        if (result[0] != undefined) {
            if (cryptr.decrypt(result[0]["password"]) == req.body["password"]) {
                var shops = [];
                if (result[0]["idRole"] == 2) {
                    result[0]["password"] = req.body["password"];
                    shops = await shopModel.getListShop(result[0]["idUser"]);
                }
                else {
                    if (result[0]["idRole"] == 1) {
                        result[0]["password"] = req.body["password"];
                        var personnel = await userModel.getPersonnel(result[0]["idUser"])
                        shops = await shopModel.getShop(personnel["idShop"]);
                        console.log(shops);
                    }
                }
                var token = jwt.sign(req.body, 'token', { expiresIn: "3h" });
                res.status(200);
                result[0]["password"] = req.body["password"];
                res.json({ 'token': token, "user": result[0], "shop": shops });
            }
            else {
                console.log(cryptr.decrypt(result[0]["password"]) == req.body["password"]);
                res.json({ "status": 400, "message": "Không đúng tên hoặc mật khẩu!" })
                res.status(400);
            }
        }
        else {
            console.log(result);
            res.json({ "status": 400, "message": "Không đúng tên hoặc mật khẩu!" })
            res.status(400);
        }
    }
    else {
        console.log("1234567890");
        res.json({ "status": 400, "message": "Không đúng tên hoặc mật khẩu!" })
        res.status = (400);
    }
}
async function changePass(req, res) {
    userModel.changePass(req.body).then((value) => {
        console.log(value);
        res.status(200);
        if (value["affectedRows"] > 0) {
            res.status(200).json({ "message": "Đổi mật khẩu thành công" })
        }
        else {
            res.status(400).json({"message":"Đổi mật khẩu không thành công"});
        }
        // res.json(
        //     { "status": 200, "message": value["affectedRows"] > 0 ? "OK" : "NOT_OK" }
        // )
    }).catch((err) => {
        console.log(err);
        res.status(400);
        res.status(400).json({"message":"Đổi mật khẩu không thành công"});
    });

}
async function getUser(req, res) {
    userModel.getUserById(req.query.idUser).then((value) => {
        res.json(value);
        res.status(200);
    }).catch((err) => {
        console.log("err", err);
        res.json(err);
        res, status(200);
    });
}
async function createPersonnel(req, res) {
    if (req.body["image"] != null && req.body["image"] != "") {
        var path = './public';
        var optionalObj = { 'fileName': "image" + Date.now(), 'type': 'png' };
        var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
        var imageName = "/upload/" + "image" + Date.now() + ".png";
        require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
            if (err) res.json({ status: 500, message: err })
            else {
                req.body["image"] = imageName;
                userModel.createUser(req.body).then((value) => {
                    userModel.getUser(req.body["username"]).then((valuee) => {
                        req.body["idUser"] = valuee[0]["idUser"];
                        userModel.createPersonnel(req.body).then((value) => {
                            res.json({
                                message: "Create user success",
                                success: true,
                            })
                        }).catch((err) => {
                            res.status(400).json({ error: "Username đã tồn tại" });
                        });
                    })

                }).catch((err) => {
                    res.status(400).json({ error: "Username đã tồn tại" });
                })
            }
        });
    }
    else {
        req.body["image"] = "";
        userModel.createUser(req.body).then((value) => {
            userModel.getUser(req.body["username"]).then((valuee) => {
                req.body["idUser"] = valuee[0]["idUser"];
                userModel.createPersonnel(req.body).then((value) => {
                    res.json({
                        message: "Create user success",
                        success: true,
                    })
                }).catch((err) => {
                    res.status(400).json({ error: "Username đã tồn tại" });
                });
            })
        }).catch((err) => {
            res.status(400).json({ error: "Username đã tồn tại" });
        })
    }
}

async function getpersonnels(req, res) {
    userModel.getpersonnels(req.query.idShop).then((value) => {
        console.log(value);
        res.status(200).json(value);
    }).catch(err => {
        res.status(400).json(err);
    })
}

async function updateUser(req, res) {
    if (req.body["image"] != null && req.body["image"] != "" && !req.body["image"].includes("/upload")) {
        var path = './public';
        var optionalObj = { 'fileName': "image" + Date.now(), 'type': 'png' };
        var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
        var imageName = "/upload/" + "image" + Date.now() + ".png";
        require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
            if (err) res.json({ status: 500, message: err })
            else {
                req.body["image"] = imageName;
                userModel.updateUser(req.body).then((value) => {
                    res.status(200).json({ "mess": "Sửa thông tin thành công" })
                }).catch((err) => {
                    console.log(err);
                    if (err["sqlMessage"].includes("username"))
                        res.status(400).json({ "error": "UserName đã được sử dụng" })
                });
            }
        });
    } else {
        userModel.updateUser(req.body).then((value) => {
            res.status(200).json({ "mess": "Sửa thông tin thành công" })
        }).catch((err) => {
            console.log(err);
            if (err["sqlMessage"].includes("username"))
                res.status(400).json({ "error": "UserName đã được sử dụng" })
        });
    }
}
function deletePersonnel(req, res) {
    userModel.deletePersonnel(req.body["idUser"]).then((value) => {
        if (value.affectedRows > 0) {
            res.status(200).json({ "mess": "Xóa nhân viên thành công" });
        }
        else res.status(400).json({ "error": "Xóa nhân viên không thành công" });
    }).catch((err) => {
        console.log(err);
        res.status(400).json({ "error": "Xóa nhân viên không thành công" });
    })
};
module.exports = {
    userLogin: userLogin,
    createUser: createUser,
    changePass: changePass,
    getUser: getUser,
    createPersonnel: createPersonnel,
    getpersonnels: getpersonnels,
    updateUser: updateUser,
    deletePersonnel: deletePersonnel,
}