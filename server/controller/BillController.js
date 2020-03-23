var billModel = require("../model/billModel")

async function createBill(req, res) {
    var result  = await billModel.insertBill(req.body);
    res.json(result);
}

async function getListBill(req, res){
    var result = await billModel.getListBill(req.query.idShop);
    res.status(200);
    res.json(result);
}
async function getCurrentBills(req, res){
    billModel.getCurrentBills(req.body).then((value)=>{
        console.log(value);
        res.status(200);
        res.json(value);
    }).catch((errr)=>{
        res.status(400);
        res.json({
            "status":400,
            "message":errr
        })
    })
    
}
module.exports={
    createBill :createBill,
    getListBill:getListBill,
    getCurrentBills:getCurrentBills,
}