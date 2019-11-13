const express = require('express');
const app = express();
const User = require('./mongoConfig');

app.use(express.static("public"));

app.get('/', (req, res) => {
  console.log('Route called');
  res.send('Hello world');
});

app.get('/fetchData', async (req, res) => {
  await User.find({}, (err, doc) => {
    if(err) {console.log(err); res.send(err);}
    if(doc) res.json(doc);
  });
});

//server port listen
app.listen(8081, () => console.log('Server starts'));