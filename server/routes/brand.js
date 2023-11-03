const brandRoutes = require("express").Router();
const { verifyAdmin } = require("../middlewares/verifyRole");
const BrandControllers = require("../controllers/BrandController");
const upload = require("../multerconfig")


brandRoutes.get("/", BrandControllers.getBrands);
//middlewarenya aku komen dulu bang
// brandRoutes.post("/create", verifyAdmin, BrandControllers.create);
// brandRoutes.put("/update/:id", verifyAdmin, BrandControllers.update);
// brandRoutes.delete("/delete/:id", verifyAdmin, BrandControllers.delete);
brandRoutes.post("/create", upload.single("images"), BrandControllers.create);
brandRoutes.put("/update/:id",upload.single("images"),  BrandControllers.update);
brandRoutes.delete("/delete/:id",  BrandControllers.delete);
module.exports = brandRoutes;
