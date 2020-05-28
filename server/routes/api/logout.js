var express = require("express");
var router = express.Router();
var jwt = require("jsonwebtoken");
var userController = require("../../controller/UserController");
var authenMiddlware = require("../../middleware/authenmiddleware");

/* GET home page. */
router.post("/", authenMiddlware, userController.userLogout);

module.exports = router;
