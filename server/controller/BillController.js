var billModel = require("../model/billModel")

async function createBill(req, res) {
    var result  = await billModel.insertBill(req.body);
    res.json(result);
}
module.exports={
    createBill :createBill,
}