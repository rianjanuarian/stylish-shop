const productRoutes = require("express").Router();
const ProductControllers = require("../controllers/ProductController");

productRoutes.get("/", ProductControllers.getData);
productRoutes.get("/detail/:id", ProductControllers.detail);
productRoutes.post("/create", ProductControllers.create);
productRoutes.delete("/delete/:id", ProductControllers.delete);
productRoutes.put("update/:id", ProductControllers.update);
module.exports = productRoutes;
