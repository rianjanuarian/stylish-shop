require("dotenv").config();
const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
const routes = require("./routes/index.js");

// Swagger
const swaggerUI = require("swagger-ui-express");
const swaggerDocs = require("./json/swagger.json");

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
app.use(express.static("public"));

// Swagger
app.use("/swagger/v1/swagger.json", (req, res) => {
  res.json(swaggerDocs);
});

app.use(
  "/swagger",
  swaggerUI.serve,
  swaggerUI.setup(swaggerDocs, {
    explorer: true,
    swaggerOptions: {
      docExpansion: "none",
      urls: [
        {
          url: "/swagger/v1/swagger.json",
          name: "v1",
        },
      ],
    },
  })
);

app.use(routes);

app.listen(port, () => console.log(`App listening on port ${port}!`));
