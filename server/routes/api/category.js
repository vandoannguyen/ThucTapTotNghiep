var express = require("express");
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var categoryController = require("../../controller/CategoryController");
router.get(
  "/listCategory",
  authenMiddlware,
  categoryController.getListCategory
);
router.post("/insert", authenMiddlware, categoryController.insertCategory);
router.post("/delete", authenMiddlware, categoryController.deleteCategory);
router.post("/update", authenMiddlware, categoryController.updateCategory);
module.exports = router;
