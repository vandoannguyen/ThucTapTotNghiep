var categoryModel = require("../model/category")
async function getListCategory(req, res)  {
   var result = await categoryModel.getListCategory(req.query.idShop);
   res.json(result)
}
async function insertCategory (req, res){
    console.log(req.body);
    
    categoryModel.insertCategory(req.body).then((value)=>{
        res.status(200);
        res.json({status:200, message:value})
    }).catch((err)=>{
        res.status(400);
        res.json({"status":400, "message":err})
    })
}
module.exports={
    getListCategory:getListCategory,
    insertCategory:insertCategory,
}