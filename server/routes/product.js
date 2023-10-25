const productRoutes = require("express").Router();
const ProductControllers = require("../controllers/ProductController");

productRoutes.get("/",ProductControllers.getData)
productRoutes.post("/create",ProductControllers.create)
productRoutes.delete("/delete/:id",ProductControllers.delete)
productRoutes.put("update/:id",ProductControllers.update)
productRoutes.get("/detail/:id",ProductControllers.detail)
module.exports = productRoutes;