require("dotenv").config();
const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
const routes = require("./routes/index.js");
//Firebase
const admin = require("firebase-admin");
const serviceAccount = require(`${process.env.SERVICE_ACCOUNT_KEY}`);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: process.env.DATABASE_URL,
});

const cors = require("cors");
app.use(cors());

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(routes);
app.listen(port, () => console.log(`App listening on port ${port}!`));
