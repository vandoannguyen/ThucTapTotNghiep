var categoryModel = require("../model/category")
async function getListCategory(req, res)  {
   var result = await categoryModel.getListCategory(req.query.idShop);
   res.json(result)
}
module.exports={
    getListCategory:getListCategory,
}