var categoryModel = require("../model/category")
async function getListCategory(req, res) {
    var result = await categoryModel.getListCategory(req.query.idShop);
    res.json(result)
}
async function insertCategory(req, res) {
    console.log(req.body);

    categoryModel.insertCategory(req.body).then((value) => {
        res.status(200);
        res.json({ status: 200, message: value })
    }).catch((err) => {
        res.status(400);
        res.json({ "status": 400, "message": err })
    })
}
function deleteCategory(req, res) {
    categoryModel.deleteCategory(req.body["idCategory"],req.body["idNoCategory"],req.body["idShop"]).then((value) => {
        if(value["affectedRows"] > 0){
            res.status(200).json({"message":"Xóa thành công"})
        }
        else res.status(400).json({"message":"Xóa không thành công"})
    }).catch((err) => {
        res.status(400).json({"message":err})
    });
}
module.exports = {
    getListCategory: getListCategory,
    insertCategory: insertCategory,
    deleteCategory: deleteCategory,
}