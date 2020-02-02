var shopModel = require("../model/shop")
async function getListShop(req, res){
    var result = await shopModel.getListShop(req.query.idShopkepper);
    console.log(result);
    res.json(result);
}
async function createShop(req,  res) {
    console.log(req.body);
    var result = await shopModel.createShop(req.body)
    console.log(result);
    res.json(result);
    
}
module.exports={
    getListShop:getListShop,
    createShop:createShop,
}