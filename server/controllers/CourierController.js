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
      const couriers = await courier.create({
        name,
        phone,
        address,
      });
      res.status(201).json({ message: "Courier has been created!", couriers });
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const { id } = req.params;
      const { name, price } = req.body;
      const couriers = await courier.update({ name, price }, { where: { id } });
      couriers[0] === 1
        ? res.status(200).json({ message: "Courier has been updated!" })
        : res.status(404).json({ message: "Courier not found!" });
    } catch (err) {
      next(err);
    }
  }

  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const couriers = await courier.destroy({ where: { id } });
      couriers === 1
        ? res.status(200).json({ message: "Courier has been deleted!" })
        : res.status(404).json({ message: "Courier not found!" });
    } catch (err) {
      next(err);
    }
  }
}

module.exports = CourierController;
