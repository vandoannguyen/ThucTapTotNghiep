var pool = require("../controller/config");

function getListThanPho() {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM province", (err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else
            reslove(rows);
        })
    })
}
function getListHuyen(province_id) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM district WHERE _province_id = ?",[province_id], (err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else
            reslove(rows);
        })
    })
}
function getListXa(district_id) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM ward WHERE _district_id = ?",[district_id], (err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else
            reslove(rows);
        })
    })
}

function getXa(id) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM ward WHERE id = ?",[id], (err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else
            reslove(rows[0]);
        })
    })
}
function getThanhPho(id) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM province where id = ?",[id], (err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else
            reslove(rows[0]);
        })
    })
}
function getHuyen(id) {
    return new Promise((reslove, reject)=>{
        pool.query("SELECT * FROM district where id = ?",[id], (err, rows)=>{
            if(err) {
                reject(err);
                throw err;
            }
            else
            reslove(rows[0]);
        })
    })
}
module.exports={
    getListThanPho:getListThanPho,
    getListHuyen:getListHuyen,
    getListXa:getListXa,
    getHuyen:getHuyen,
    getXa:getXa,
    getThanhPho:getThanhPho,
}