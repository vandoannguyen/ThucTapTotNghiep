var express = require('express');
var router = express.Router();
var diaChi = require("../../model/diachi")
var authenMiddlware = require("../../middleware/authenmiddleware")


/* GET home page. */
router.get('/listthanhpho',authenMiddlware, (req, res)=>{
    diaChi.getListThanPho().then((rows)=>{
        res.json(rows);
    }).catch((err)=>{
        res.status(404);
    })
}) ;
router.get('/listhuyen', authenMiddlware,(req, res)=>{
    diaChi.getListHuyen(req.query.idThanhPho).then((rows)=>{
        res.json(rows);
    }).catch((err)=>{
        res.status(404);
    })
}) ;
router.get('/listxa', authenMiddlware,(req, res)=>{
    diaChi.getListXa(req.query.idHuyen).then((rows)=>{
        res.json(rows);
    }).catch((err)=>{
        res.status(404);
    })
}) ;
router.get('/thanhpho', authenMiddlware,(req, res)=>{
    diaChi.getThanhPho(req.query.idThanhPho).then((rows)=>{
        res.json(rows);
    }).catch((err)=>{
        res.status(404);
    })
}) ;
router.get('/huyen',authenMiddlware, (req, res)=>{
    diaChi.getHuyen(req.query.idHuyen).then((rows)=>{
        res.json(rows);
    }).catch((err)=>{
        res.status(404);
    })
}) ;
router.get('/xa', (req, res)=>{
    diaChi.getXa(req.query.idXa).then((rows)=>{
        res.json(rows);
    }).catch((err)=>{
        res.status(404);
    })
}) ;
module.exports = router;
