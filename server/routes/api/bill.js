var express = require('express');
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware")
var billController = require("../../controller/BillController")
// router.get("/listbill",authenMiddlware,billController);
router.post("/createbill",authenMiddlware,billController.createBill);

module.exports = router;