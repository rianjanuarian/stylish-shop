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
      const { name, price } = req.body;
      const image = req.file.filename;
      const newCourier = await courier.create({ name, price, image });
      res.status(201).json({
        message: "Courier has been created!",
        newCourier,
      });
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

      const { name, price } = req.body;
      const image = req.file.filename;

      const response = await currentCourier.update({ name, price, image });
      response.dataValues
        ? res
            .status(200)
            .json({ message: "Courier has been updated!", data: response.dataValues })
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

  static async getOneCourier(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const currentCourier = await courier.findByPk(id);

      if (!currentCourier) {
        return next(createError(404, "Courier does not exist!"));
      }

      res.status(200).json(currentCourier);
    } catch (error) {
      next(error);
    }
  }
}

module.exports = CourierController;
