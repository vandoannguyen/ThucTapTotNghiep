var express = require('express');
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var merchandiseController = require("../../controller/MerchandiseController");

router.get("/list",authenMiddlware,merchandiseController.getMerchandises);
router.get("/listMerchandis",authenMiddlware,merchandiseController.getListMerchandis);
router.post("/createMerchandise", authenMiddlware, merchandiseController.createMerchandies);

module.exports = router;