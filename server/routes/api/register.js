var express = require("express");
var router = express.Router();
var nodemailer = require("nodemailer");
var jwt = require("jsonwebtoken");
/* GET home page. */
var userController = require("../../controller/UserController");
router.post("/", userController.createUser);
// {
//   // console.log(req.body);
//   userController.createUser(req,res);
//     // var transporter = nodemailer.createTransport({
//     //     service: 'gmail',
//     //     auth: {
//     //       user: 'youremail@gmail.com',
//     //       pass: 'yourpassword'
//     //     }
//     //   });

//     //   var mailOptions = {
//     //     from: 'youremail@gmail.com',
//     //     to: 'myfriend@yahoo.com',
//     //     subject: 'Sending Email using Node.js',
//     //     text: 'That was easy!'
//     //   };

//     //   transporter.sendMail(mailOptions, function(error, info){
//     //     if (error) {
//     //       console.log(error);
//     //     } else {
//     //       console.log('Email sent: ' + info.response);
//     //     }
//     //   });
// });

module.exports = router;
