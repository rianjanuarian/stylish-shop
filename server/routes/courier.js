const courierRoutes = require("express").Router();
const { verifyAdmin } = require("../middlewares/verifyRole");
const CourierControllers = require("../controllers/CourierController");
const upload = require("../multerconfig");

courierRoutes.get("/", CourierControllers.getCouriers);
courierRoutes.post("/create", verifyAdmin, upload.single("images"), CourierControllers.create);
courierRoutes.put("/update/:id", verifyAdmin, upload.single("images"), CourierControllers.update);
courierRoutes.delete("/delete/:id", verifyAdmin, CourierControllers.delete);
courierRoutes.get("/getOneCourier/:id", CourierControllers.getOneCourier);

module.exports = courierRoutes;
