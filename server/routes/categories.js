const categoriesRoutes = require("express").Router();
const CategoriesControllers = require("../controllers/CategoriesControllers");

// categoriesRoutes.get("/", CategoriesControllers.getCategories);
// categoriesRoutes.post("/create", CategoriesControllers.create);
// categoriesRoutes.put("/update/:id", CategoriesControllers.update);
// categoriesRoutes.delete("/delete/:id", CategoriesControllers.delete);

module.exports = categoriesRoutes;
