const productRoutes = require("express").Router();
const ProductControllers = require("../controllers/ProductController");

productRoutes.get("/", ProductControllers.getData);
productRoutes.get("/detail/:id", ProductControllers.detail);
productRoutes.post("/create", ProductControllers.create);
productRoutes.delete("/delete/:id", ProductControllers.delete);
productRoutes.put("/update/:id", ProductControllers.update);
productRoutes.get("/category/:id", ProductControllers.getProductsByCategories);
productRoutes.get("/brand/:id", ProductControllers.getProductsByBrands);
productRoutes.get("/search", ProductControllers.getProductsBySearch);
productRoutes.get("/search/category", ProductControllers.getProductsBycategorySearch);
productRoutes.get("/search/brand", ProductControllers.getProductsBybrandSearch);

module.exports = productRoutes;
