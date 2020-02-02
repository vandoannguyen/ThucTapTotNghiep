var merchandiseModel = require("../model/merchandisedetail")

async function getMerchandises(req, res) {
   merchandiseModel.getListMerchandise(req.query.idCuaHang).then((result)=>{
       console.log(result);
       res.json(result)
   }).catch((err)=>{
       console.log("error",err);
       res.json(err);
   });    
}
module.exports={
    getMerchandises:getMerchandises,
}