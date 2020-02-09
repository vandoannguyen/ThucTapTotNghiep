var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var loginRouter = require('./routes/api/login');
var registerRouter = require("./routes/api/register");
var shopRouter = require("./routes/api/shop");
var merchandiseRouter = require("./routes/api/merchandise");
var diaChiRouter = require("./routes/api/diachi");
var billRouter = require("./routes/api/bill");
var categoryRouter = require("./routes/api/category");
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json({limit: '20mb', extended: true }));
app.use(express.urlencoded({limit: '20mb', extended: true }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'upload')));

app.use('/api/diachi', diaChiRouter);
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/api/login', loginRouter);
app.use('/api/register', registerRouter);
app.use('/api/shop', shopRouter);
app.use('/api/merchandise', merchandiseRouter);
app.use('/api/bill', billRouter);
app.use('/api/category', categoryRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
