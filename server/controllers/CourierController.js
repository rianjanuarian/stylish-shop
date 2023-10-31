const createError = require("../middlewares/createError");
const { courier } = require("../models");

class CourierController {
  static async getCouriers(req, res, next) {
    try {
      const couriers = await courier.findAll();
      res.status(200).json(couriers);
    } catch (err) {
      next(err);
    }
  }
  static async create(req, res, next) {
    try {
      const newCourier = await courier.create(req.body);
      res
        .status(201)
        .json({ message: "Courier has been created!", newCourier });
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const currentCourier = await courier.findByPk(id);

      if (!currentCourier) {
        return next(createError(404, "Courier does not exist!"));
      }

      const response = await currentCourier.update(req.body);
      response.dataValues
      ? res.status(200).json({ message: "Courier has been updated!" })
      : next(createError(400, "Courier has not been updated!"));
    } catch (err) {
      next(err);
    }
  }

  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const currentCourier = await courier.findByPk(id);
      
      if (!currentCourier) {
        return next(createError(404, "Courier does not exist!"));
      }

      await currentCourier.destroy();
      res.status(200).json({ message: "Courier has been deleted!" });
    } catch (err) {
      next(err);
    }
  }
}

module.exports = CourierController;
