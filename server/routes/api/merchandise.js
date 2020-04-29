var express = require('express');
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var merchandiseController = require("../../controller/MerchandiseController");

router.get("/list",authenMiddlware,merchandiseController.getMerchandises);
router.get("/listMerchandis",authenMiddlware,merchandiseController.getListMerchandise);
router.get("/listMerchandisByBill", authenMiddlware, merchandiseController.getMerchandisesByBill);
router.post("/createMerchandise", authenMiddlware, merchandiseController.createMerchandise);
router.post("/updatemerchandise", authenMiddlware, merchandiseController.updateMerchandises);
router.post("/getbestseller", authenMiddlware, merchandiseController.getBestSeller);
router.post("/getMerchandisewillempty", authenMiddlware, merchandiseController.getMerchandiseWillEmpty);
router.post("/deleteMerchandise", authenMiddlware, merchandiseController.deletemerchandise);

module.exports = router;