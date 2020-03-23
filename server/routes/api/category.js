var express = require('express');
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var categoryController = require("../../controller/CategoryController");
router.get("/listCategory", authenMiddlware, categoryController.getListCategory);
router.post("/insert", authenMiddlware, categoryController.insertCategory);
module.exports = router;