const productRoutes = require("express").Router();
const ProductControllers = require("../controllers/ProductController");
const {verifyAdmin} = require('../middlewares/verifyRole');
const upload = require("../multerconfig")

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

//Admin Only :: bang aku komen dulu ya soalnya yg consume login di cmsnya masih belum ntar kalo consume loginnya udh aku uncomment 
// productRoutes.post("/create", verifyAdmin, ProductControllers.create);
// productRoutes.put("/update/:id",  verifyAdmin, ProductControllers.update);
// productRoutes.delete("/delete/:id",  verifyAdmin, ProductControllers.delete);

productRoutes.post("/create",  upload.single("images"),ProductControllers.create);
productRoutes.put("/update/:id",  upload.single("images"), ProductControllers.update);
productRoutes.delete("/delete/:id",   ProductControllers.delete);

module.exports = productRoutes;
