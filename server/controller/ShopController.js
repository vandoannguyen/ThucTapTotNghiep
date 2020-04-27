var shopModel = require("../model/shop")
async function getListShop(req, res) {
    var result = await shopModel.getListShop(req.query.idShopkepper);
    console.log(result);
    res.json(result);
}
async function createShop(req, res) {
    console.log(req.body);
    var result = await shopModel.createShop(req.body)
    console.log(result);
    res.json(result);

}
function updateShop(req, res) {
    shopModel.updateShop(req.body).then((value) => {
        console.log(value);
        if (value["affectedRows"] > 0)
            res.status(200).json({message:"Cập nhật thông tin không thành công"});
        else res.status(400).json({message:"Cập nhật không thành công"})
    }).catch((err) => {
        console.log(err);
        
        res.status(400).json({message:err});
    })

}
module.exports = {
    getListShop: getListShop,
    createShop: createShop,
    updateShop: updateShop,
}