var mysql = require("mysql")
// var pool = 
module.exports=mysql.createPool({
    connectionLimit : 50,
    host            : 'us-cdbr-iron-east-01.cleardb.net',
    user            : 'bb1fbf2375d8df',
    password        : '1e43bb21',
    database        : 'heroku_71ef7c2903f3013'
});
// module.exports=mysql.createPool({
//     connectionLimit : 100,
//     host            : 'localhost',
//     user            : 'root',
//     password        : '',
//     database        : 'smart_shop'
// });  