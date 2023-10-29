const categoriesProductRoutes = require("express").Router();
const CategoriesProductControllers = require('../controllers/CategoriesControllers');

categoriesProductRoutes.get('/', CategoriesProductControllers.getCategories);
categoriesProductRoutes.post('/create', CategoriesProductControllers.create);
categoriesProductRoutes.post('/update/:id', CategoriesProductControllers.update);
categoriesProductRoutes.delete('/delete', CategoriesProductControllers.delete);





module.exports = categoriesProductRoutes;