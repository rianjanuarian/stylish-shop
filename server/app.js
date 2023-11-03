require("dotenv").config();
const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
const routes = require("./routes/index.js");

//Firebase
const admin = require("firebase-admin");
const serviceAccount = require("./helpers/stylishshop-562a7-firebase-adminsdk-dap1r-fae3f7b89d.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://stylishshop-562a7.firebaseio.com",
});

const cors = require("cors");
app.use(cors());

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'))
app.use(routes);
app.listen(port, () => console.log(`App listening on port ${port}!`));
