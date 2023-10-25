const brandRoutes = require("./brand");
const brandProductRoutes = require("./brandproduct")
const categoriesRoutes = require("./categories")
const productRoutes = require("./product")
const userRoutes = require('./user')
const categoriesProductRoutes = require("./categoriesproduct")
const courierRoutes = require("./courier")
const reviewRoutes = require("./review")
const transactionRoutes = require("./transaction")

const route = require("express").Router();

route.get("/", (req, res) => {
  res.send({ message: "homepage" });
});

route.use("/brands",brandRoutes)
route.use(".brandProducts",brandProductRoutes)
route.use("./categories",categoriesRoutes)
route.use("./categoriesProducts",categoriesProductRoutes)
route.use("./products",productRoutes)
route.use("./users",userRoutes)
route.use("./couriers",courierRoutes)
route.use("./reviews",reviewRoutes)
route.use("./transactions",transactionRoutes)

module.exports = route;