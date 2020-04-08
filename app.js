const express = require('express');
const app = express();
const {readFileSync, writeFileSync} = require('fs');

const d = require('./dir/test.json');
console.log(d);

// writeFileSync(`./dir/test.json`, JSON.stringify({name: 'tarun'}), 'utf8');

// app.use(express.static("public"));

app.get('/test', (req, res) => {
  const data = require('./dir/test.json');
  console.log('Route called', data);
  res.send('Hello world', data.name);
});

//server port listen
app.listen(3000, () => console.log('Server starts'));