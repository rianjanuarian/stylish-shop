const brandRoutes = require("express").Router();
const { verifyAdmin } = require("../middlewares/verifyRole");
const BrandControllers = require("../controllers/BrandController");
const upload = require("../multerconfig");

brandRoutes.get("/", BrandControllers.getBrands);
brandRoutes.post(
  "/create",
  verifyAdmin,
  upload.single("images"),
  BrandControllers.create
);
brandRoutes.put(
  "/update/:id",
  verifyAdmin,
  upload.single("images"),
  BrandControllers.update
);
brandRoutes.delete("/delete/:id", BrandControllers.delete);
module.exports = brandRoutes;
