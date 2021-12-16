var express = require('express');
var app = express();


app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});

app.set('view engine', 'ejs');

app.get('/', function (req, res, next) {
  res.render('index', {});
});
