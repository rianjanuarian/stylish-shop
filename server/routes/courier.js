const courierRoutes = require("express").Router();
const CourierControllers = require("../controllers/CourierController");

courierRoutes.get("/", CourierControllers.getCouriers);
courierRoutes.post("/create", CourierControllers.create);
courierRoutes.put("/update/:id", CourierControllers.update);
courierRoutes.delete("/delete/:id", CourierControllers.delete);

module.exports = courierRoutes;
