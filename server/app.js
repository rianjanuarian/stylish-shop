require("dotenv").config();
const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
const routes = require("./routes/index.js");
const cors = require("cors");

//Firebase
const admin = require("firebase-admin");
const serviceAccount = require("./helpers/stylishshop-562a7-firebase-adminsdk-dap1r-fae3f7b89d.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://stylishshop-562a7.firebaseio.com",
});

app.use(cors({
  origin: 'http://localhost:3001',
  methods: 'GET,POST,PUT,DELETE',
  allowedHeaders: 'Content-Type, Authorization, access_token',
  credentials: true,
}));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'))
app.use(routes);
app.listen(port, () => console.log(`App listening on port ${port}!`));
