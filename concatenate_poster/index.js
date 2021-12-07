var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

app.get('/about', function (req, res) {
  res.send('About page');
});

app.get('/login', function(req, res) {
  res.send('Login page');
});

app.get('/logout', function(req, res) {
  res.send('Logout page');
});

app.get('/upload', function(req, res) {
  res.send('Upload page');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});