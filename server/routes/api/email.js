var express = require("express");
var router = express.Router();
var authenMiddlware = require("../../middleware/authenmiddleware");
var nodemailer = require("nodemailer");
var transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "smartshop.co.app@gmail.com",
    pass: "Vandoan98",
  },
});
router.post("/send", authenMiddlware, (req, res) => {
  var mailOptions = {
    from: "smartshop.co.app@gmail.com",
    to: "vandoannguyenhaui@gmail.com",
    subject: "THÔNG BÁO CẦN NHẬP HÀNG",
    html:
      `<h1>Xin chào bạn</h1> 
      <p>Cửa hàng:` +
      req.body.shopName +
      `</p> 
      <p>Tại: ` +
      req.body.address +
      `</p>
      <p>Hiện tại đang cấn nhập thêm sản phấm:</p>
      <p>Tên sản phẩm:` +
      req.body.merchandiseName +
      `</p>
      <p>Mã barcode: ` +
      req.body.barcode +
      `</p>
      <p>Số lượng: ` +
      req.body.count +
      `</p>
      <p>Bạn vui lòng kiểm tra lại thông tin chính xác</p>
      <p>Số điện thoại cửa hàng: ` +
      req.body.phoneNumber +
      `</p>`,
  };
  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      res.status(400).json({ error: error });
    } else {
      res.status(200).json({});
    }
  });
});

module.exports = router;
