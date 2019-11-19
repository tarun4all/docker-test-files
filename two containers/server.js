const express = require('express');
const app = express();
const mongoose = require("mongoose");
require('dotenv').config();

console.log('Env variables are there: ..', process.env.MONGO_PONGO);
mongoose.connect('mongodb://mongo:27017/newdock', () => {
    console.log("Connected to the DB");
}, (err) => {
    console.log(err);
});

const Schema  = mongoose.Schema;
const userSchema = new Schema({name : String, sex : String , designation : String});
const User = mongoose.model("users",userSchema);

User.insertMany([{name: 'Tarun Bansal', sex: 'Male', designation: 'Full stack Developer'}, {name: 'Danish', sex: 'Female', designation: 'CTO'}], (err, docs) => {
    if(err) console.log('error occures while inserting..');
    if(docs) console.log('Test Data inserted');
});

app.get('/', async (req, res) => {
    await User.find({}, (err, doc) => {
        if(err) {console.log(err); res.send(err);}
        if(doc) res.send(doc);
    });
});

app.listen(4000, () => console.log('server running'));