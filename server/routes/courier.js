const courierRoutes = require("express").Router();
const { verifyAdmin } = require("../middlewares/verifyRole");
const CourierControllers = require("../controllers/CourierController");

courierRoutes.get("/", CourierControllers.getCouriers);
courierRoutes.post("/create", verifyAdmin, CourierControllers.create);
courierRoutes.put("/update/:id", verifyAdmin, CourierControllers.update);
courierRoutes.delete("/delete/:id", verifyAdmin, CourierControllers.delete);

module.exports = courierRoutes;
