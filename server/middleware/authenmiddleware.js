var jwt  = require("jsonwebtoken")
module.exports = (req, res, next)=>{
    if (req.headers.authorization && req.headers.authorization.split(' ')[0] === 'Bearer') {
        var token = req.headers.authorization.split(' ')[1];
        console.log(token);
        var demo = jwt.verify(token,"token",(err,decoded)=>{
            if(err)return res.json({
                success: false,
                message: 'Token is not valid'
              });
              else {
                  console.log(decoded);
                req.decoded = decoded;
                next();
              }
        })
    }
    else return res.json({
        success: false,
        message: 'Auth token is not supplied'
      });
    // jwt.verify()
}