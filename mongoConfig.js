const mongoose = require("mongoose");
const db = {
    url : "mongodb://0.0.0.0:27017/test123",
}

mongoose.connect(db.url, () => {
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

module.exports = User;