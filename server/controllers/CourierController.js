const { courier } = require("../models");

class CourierController {
  static async getCouriers(req, res, next) {
    try {
      const couriers = await courier.findAll();
      res.json(couriers);
    } catch (err) {
      next(err);
    }
  }
  static async create(req, res, next) {
    try {
      const { name, phone, address } = req.body;
      const courier = await courier.create({
        name,
        phone,
        address,
      });
      res.json(courier);
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const { id } = req.params;
      const { name, phone, address } = req.body;
      const courier = await courier.update(
        { name, phone, address },
        { where: { id } }
      );
      res.json(courier);
    } catch (err) {
      next(err);
    }
  }

  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const courier = await courier.destroy({ where: { id } });
      res.json(courier);
    } catch (err) {
      next(err);
    }
  }
}

module.exports = CourierController;
