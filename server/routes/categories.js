const categoriesRoutes = require("express").Router();
const CategoriesControllers = require("../controllers/CategoriesControllers");
const { verifyAdmin } = require("../middlewares/verifyRole");

categoriesRoutes.get("/", CategoriesControllers.getCategories);

//aku komen dulu bang middlewarenya
// categoriesRoutes.post("/create", verifyAdmin, CategoriesControllers.create);
// categoriesRoutes.put("/update/:id", verifyAdmin, CategoriesControllers.update);
// categoriesRoutes.delete(
//   "/delete/:id",
//   verifyAdmin,
//   CategoriesControllers.delete
// );

categoriesRoutes.post("/create",  CategoriesControllers.create);
categoriesRoutes.put("/update/:id",  CategoriesControllers.update);
categoriesRoutes.delete(
  "/delete/:id",
  
  CategoriesControllers.delete
);

module.exports = categoriesRoutes;
