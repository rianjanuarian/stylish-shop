const courierRoutes = require("express").Router();
const BrandControllers = require("../controllers/CourierController");

courierRoutes.get("/", BrandControllers.getCouriers);
courierRoutes.post("/create", BrandControllers.create);
courierRoutes.put("/update/:id", BrandControllers.update);
courierRoutes.delete("/delete/:id", BrandControllers.delete);

module.exports = courierRoutes;
