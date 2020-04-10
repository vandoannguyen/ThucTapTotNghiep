var express = require('express');
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var userController = require("../../controller/UserController")
/* GET users listing. */
router.post('/changepassword',authenMiddlware, userController.changePass);
router.get("/user", authenMiddlware, userController.getUser)
module.exports = router;
