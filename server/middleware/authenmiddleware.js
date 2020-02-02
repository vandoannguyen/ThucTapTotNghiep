var jwt  = require("jsonwebtoken")
module.exports = (req, res, next)=>{
  console.log(req.headers.authorization);
  console.log(req.headers.authorization.split(' ')[0]+"" );
  
  
    if (req.headers.authorization && req.headers.authorization.split(' ')[0]=="Bearer") {
        var token = req.headers.authorization.split(' ')[1];
        var demo = jwt.verify(token,"token",(err,decoded)=>{
            if(err){
                res.status(401);
                res.json({
                success: false,
                message: 'Unauthorized '
              });}
              else {
                  res.status(200);
                  console.log(decoded);
                req.decoded = decoded;
                next();
              }
        })
    }
    else { res.status(401); res.json({
        success: false,
        message: 'Auth token is not supplied'
      });}
    // jwt.verify()
}