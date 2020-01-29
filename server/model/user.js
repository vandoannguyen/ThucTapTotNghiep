var pool = require("../controller/config");
function getUser(username, callback) {
    // pool.getConnection((err, connection)=>{
        console.log     ("demogjasdasdas   ")
        // if(err) throw err;
       return new Promise((reslove, reject)=>{
        pool.query("select * from user where username = '"+ username +"'", (err, rows)=>{
            if(err) reject(err);
            else reslove(rows)
        });
       } );
    // }
    // )
    
}
function createUser(params) {
    
}
module.exports={
    getUser:getUser,
}