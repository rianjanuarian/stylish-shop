const brandRoutes = require("express").Router();
const { verifyAdmin } = require("../middlewares/verifyRole");
const BrandControllers = require("../controllers/BrandController");

brandRoutes.get("/", BrandControllers.getBrands);
brandRoutes.post("/create", verifyAdmin, BrandControllers.create);
brandRoutes.put("/update/:id", verifyAdmin, BrandControllers.update);
brandRoutes.delete("/delete/:id", verifyAdmin, BrandControllers.delete);
module.exports = brandRoutes;
