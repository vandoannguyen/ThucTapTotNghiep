var express = require('express');
var router = express.Router();
var jwt = require('jsonwebtoken');
var userController = require("../../controller/UserController")

/* GET home page. */
router.post('/', userController.userLogin) ;

module.exports = router;
