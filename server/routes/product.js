const productRoutes = require("express").Router();
const ProductControllers = require("../controllers/ProductController");
const {verifyAdmin} = require('../middlewares/verifyRole');

productRoutes.get("/", ProductControllers.getData);
productRoutes.get("/detail/:id", ProductControllers.detail);
productRoutes.get("/category/:id", ProductControllers.getProductsByCategories);
productRoutes.get("/brand/:id", ProductControllers.getProductsByBrands);
productRoutes.get("/search", ProductControllers.getProductsBySearch);
productRoutes.get(
  "/search/category",
  ProductControllers.getProductsBycategorySearch
);
productRoutes.get("/search/brand", ProductControllers.getProductsBybrandSearch);

//Admin Only
productRoutes.post("/create", verifyAdmin, ProductControllers.create);
productRoutes.put("/update/:id",  verifyAdmin, ProductControllers.update);
productRoutes.delete("/delete/:id",  verifyAdmin, ProductControllers.delete);

module.exports = productRoutes;
