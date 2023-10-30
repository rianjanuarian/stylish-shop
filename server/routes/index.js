const brandRoutes = require("./brand");
const categoriesRoutes = require("./categories");
const productRoutes = require("./product");
const userRoutes = require("./user");
const courierRoutes = require("./courier");
const reviewRoutes = require("./review");
const cartRoutes = require("./cart");
const transactionRoutes = require("./transaction");
const errorMiddleware = require("./error");

const route = require("express").Router();

route.get("/", (req, res) => {
  res.send({ message: "Welcome to StylishShop" });
});

route.use("/brands", brandRoutes);
route.use("/categories", categoriesRoutes);
route.use("/products", productRoutes);
route.use("/users", userRoutes);
route.use("/couriers", courierRoutes);
route.use("/reviews", reviewRoutes);
route.use("/transactions", transactionRoutes);
route.use("/carts", cartRoutes);
route.use(errorMiddleware);

module.exports = route;
