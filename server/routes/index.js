const brandRoutes = require("./brand");
const brandProductRoutes = require("./brandproduct");
const categoriesRoutes = require("./categories");
const productRoutes = require("./product");
const userRoutes = require("./user");
const categoriesProductRoutes = require("./categoriesproduct");
const courierRoutes = require("./courier");
const reviewRoutes = require("./review");
const transactionRoutes = require("./transaction");
const errorMiddleware = require('./error');

const route = require("express").Router();

route.get("/", (req, res) => {
  res.send({ message: "Welcome to StylishShop" });
});

route.use("/brands", brandRoutes);
route.use("/brandProducts", brandProductRoutes);
route.use("/categories", categoriesRoutes);
route.use("/categoriesProducts", categoriesProductRoutes);
route.use("/products", productRoutes);
route.use("/users", userRoutes);
route.use("/couriers", courierRoutes);
route.use("/reviews", reviewRoutes);
route.use("/transactions", transactionRoutes);
route.use(errorMiddleware);

module.exports = route;
