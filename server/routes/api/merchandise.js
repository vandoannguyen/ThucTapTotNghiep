var express = require('express');
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var merchandiseController = require("../../controller/MerchandiseController");

router.get("/listMerchandise",authenMiddlware,merchandiseController.getMerchandises);

module.exports = router;