const cartRoutes = require("express").Router();
const CartController = require("../controllers/CartController");
const { verifyUser } = require("../middlewares/verifyRole");

cartRoutes.get("/user", verifyUser, CartController.getProductsByUserId);
cartRoutes.get("/detail/:id", verifyUser, CartController.getDetailCart);
cartRoutes.post("/create", verifyUser, CartController.create);
cartRoutes.put("/update/:id", verifyUser, CartController.update);
cartRoutes.delete("/delete/:id", verifyUser, CartController.delete);

module.exports = cartRoutes;
