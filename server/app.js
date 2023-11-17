require("dotenv").config();
const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
const routes = require("./routes/index.js");
const cors = require("cors");
const { Storage } = require('@google-cloud/storage');
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

//template
const storage = new Storage({
  keyFilename: 'cloud-storage.json', 
  projectId: '7c8c89da30790dc43d65677a33d2b042d6b3e7b3', 
});

const bucket = storage.bucket('stylish-shop'); 

const corsOptions = {
  allowedHeaders: 'Content-Type, Authorization', 
  origin: 'http://localhost:3001', 
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true, 
  optionsSuccessStatus: 204,
};
app.use(cors(corsOptions));

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