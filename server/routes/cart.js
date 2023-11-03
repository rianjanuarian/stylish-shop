const cartRoutes = require("express").Router();
const CartController = require("../controllers/CartController");
const { verifyUser } = require("../middlewares/verifyRole");

cartRoutes.post("/create", verifyUser, CartController.create);
cartRoutes.get("/user", verifyUser, CartController.getProductsByUserId);
cartRoutes.get("/user/:id", verifyUser, CartController.getDetailCart);
cartRoutes.put("/update/:id", verifyUser, CartController.update);
cartRoutes.delete("/delete/:id", verifyUser, CartController.delete);

module.exports = cartRoutes;
