var merchandiseModel = require("../model/merchandisedetail")
var categoryModel = require("../model/category");

async function getMerchandises(req, res) {
    var listCategory = await categoryModel.getListCategory(req.query.idShop);
    console.log(listCategory);
    for(let i=0;i<listCategory.length;i++){
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
async function getListMerchandis(req, res) {
    var listMerchandis  = await merchandiseModel.getListMerchandise({key:"idShop", value:req.query.idShop})
    res.json(listMerchandis);
}
async function createMerchandies(req, res) {
    // console.log(req.body);
    // 
    var base64Data = req.body["image"].replace(/^data:image\/png;base64,/, "");
    var imageName = "/upload/" + "image" + Date.now() + ".png";
    var path = './public';
    require("fs").writeFile(path + imageName, base64Data, 'base64', function (err) {
        if (err) res.json({ status: 500, message: err })
        else {
            req.body["image"] = imageName;
            merchandiseModel.createMerchandis(req.body).then((value) => {
                res.status = 200,
                    console.log("ok");
                res.json({ "success": true, "message": "ok" })
            }).catch((err) => {
                console.log(err);

                res.status = 500, 
                    res.json({ "success": false, "message": err })
            })
        }
    });

}
module.exports = {
    getMerchandises: getMerchandises,
    createMerchandies: createMerchandies,
    getListMerchandis:getListMerchandis
}