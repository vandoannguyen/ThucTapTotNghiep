var mysql = require("mysql")
// var pool = 
module.exports=mysql.createPool({
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    password        : '',
    database        : 'smart_shop'
});