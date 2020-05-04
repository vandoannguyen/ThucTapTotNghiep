var merchandiseModel = require("../model/merchandisedetail")
var categoryModel = require("../model/category");

async function getMerchandises(req, res) {
    var listCategory = await categoryModel.getListCategory(req.query.idShop);
    console.log(listCategory);
    for (let i = 0; i < listCategory.length; i++) {
        listCategory[i]["listMechandise"] = await merchandiseModel.getListMerchandise({ key: "idCategory", value: listCategory[i]["idCategory"] });
        console.log(listCategory[i]["listMechandise"]);

    }
    // listCategory.forEach((element) => {
    //     element
    //     console.log(element);
    // });
    res.json(listCategory);
    // var result = await merchandiseModel.getListMerchandise(req.query.idShop).then((result) => {
    // console.log(result);
    // }).catch((err) => {
    // console.log("error", err);
    // res.json(err);
    // });
}
async function getListMerchandise(req, res) {
    var listMerchandis = await merchandiseModel.getListMerchandise({ key: "idShop", value: req.query.idShop })
    res.json(listMerchandis);
}
async function getMerchandisesByBill(req, res) {
    console.log(req.query.idBill);
    var listMerchandis = await merchandiseModel.getListMerchandiseByBill({ idBill: req.query.idBill, idShop: req.query.idShop })
    res.json(listMerchandis);
}
async function createMerchandise(req, res) {
    // console.log(req.body);
    // 
    var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
    var imageName = "/upload/" + "image" + Date.now() + ".png";
    var path = './public';
    require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
        if (err) res.json({ status: 500, message: err })
        else {
            req.body["image"] = imageName;
            merchandiseModel.createMerchandise(req.body).then((value) => {
                res.status(200).json({ "success": true, "value": value })
            }).catch((err) => {
                console.log(err);
                res.status(400).json({ "success": false, "message": err })
            })
        }
    });

}

async function updateMerchandises(req, res) {
    // chưa xóa ảnh cũ đi
    if (!req.body["image"].includes("upload")) {
        var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
        var imageName = "/upload/" + "image" + Date.now() + ".png";
        var path = './public';
        require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
            if (err) res.json({ status: 500, message: err })
            else {
                req.body["image"] = imageName;
                merchandiseModel.updateMerchandises(req.body).then((value) => {
                    res.status (200).json({ "success": true, "message": "ok" }),
                        console.log("ok");
                }).catch((err) => {
                    console.log(err);
                    res.status (400).json({ "success": false, "message": err });
                })
            }
        });
    } else {
        merchandiseModel.updateMerchandises(req.body).then((value) => {
            res.status = 200,
                console.log("ok");
            res.json({ "success": true, "message": "ok" })
        }).catch((err) => {
            console.log(err);
            res.status = 500,
                res.json({ "success": false, "message": err })
        })
    }
}
async function getBestSeller(req, res) {
    var result = await merchandiseModel.getBestSeller(req.body);
    if (result != null) {
        console.log(result);

        res.status(200);
        res.json(result);
    }
}
async function getMerchandiseWillEmpty(req, res) {
    var result = await merchandiseModel.getMerchandiseWillEmpty(req.body);
    if (result != null) {
        console.log(result);
        res.status(200);
        res.json(result);
    }
    else res.json([]);
}
function deletemerchandise(req, res) {
    console.log(req.body);

    merchandiseModel.deletemerchandise(req.body["barcode"], req.body["idShop"]).then((value) => {
        if(value["affectedRows"] >0){
            res.status(200).json({"status":"ok"});
        }
        else res.status(400).json({"status":"notok"});
        console.log(value);
    }).catch((err) => {
        console.log(err);
        res.status(400).json({"status":"notok"});
    })
}
module.exports = {
    getMerchandises: getMerchandises,
    createMerchandise: createMerchandise,
    getListMerchandise: getListMerchandise,
    getMerchandisesByBill: getMerchandisesByBill,
    getBestSeller: getBestSeller,
    getMerchandiseWillEmpty: getMerchandiseWillEmpty,
    updateMerchandises: updateMerchandises,
    deletemerchandise: deletemerchandise,
}   