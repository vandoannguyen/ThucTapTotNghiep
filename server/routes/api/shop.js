var express = require("express");
var router = express.Router();
var shopController = require("../../controller/ShopController");
var authenMiddlware = require("../../middleware/authenmiddleware");

router.get("/listshop", authenMiddlware, shopController.getListShop);

// {
//     name: 'demoName',
//     address: 'demoAddess',
//     idShopkepper: '8',
//     image: ''
//   }
router.post("/createshop", authenMiddlware, shopController.createShop);
router.post("/updateshop", authenMiddlware, shopController.updateShop);
router.post("/deleteShop", authenMiddlware, shopController.deleteShop);
router.post("/listShop", authenMiddlware, shopController.listShop);
module.exports = router;
