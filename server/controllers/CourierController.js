const { courier } = require("../models");

class CourierController {
  static async getCouriers(req, res) {
    try {
      const couriers = await courier.findAll();
      res.json(couriers);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
  static async create(req, res) {
    try {
      const { name, phone, address } = req.body;
      const courier = await courier.create({
        name,
        phone,
        address,
      });
      res.json(courier);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static async update(req, res) {
    try {
      const { id } = req.params;
      const { name, phone, address } = req.body;
      const courier = await courier.update(
        { name, phone, address },
        { where: { id } }
      );
      res.json(courier);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static async delete(req, res) {
    try {
      const { id } = req.params;
      const courier = await courier.destroy({ where: { id } });
      res.json(courier);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
}

module.exports = CourierController;
