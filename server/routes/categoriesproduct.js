const categoriesProductRoutes = require("express").Router();
const CategoriesProductControllers = require("../controllers/BrandController");


categoriesProductRoutes.get('/', (req, res) => {
    res.json({test: 'test'})
})


module.exports = categoriesProductRoutes;