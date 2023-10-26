const { brand } = require("../models");

class BrandControllers {
  static async getBrands(req, res) {
    try {
      const brands = await brand.findAll();
      res.status(200).json(brands);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static async create(req, res) {
    try {
      const { name, image } = req.body;
      const brand = await brand.create({ name, image });
      res.status(200).json(brand);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
  static async update(req, res) {
    try {
      const { id } = req.params;
      const { name, image } = req.body;
      const brand = await brand.update({ name, image }, { where: { id } });
      res.status(200).json(brand);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
  static async delete(req, res) {
    try {
      const { id } = req.params;
      const brand = await brand.destroy({ where: { id } });
      res.status(200).json(brand);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
}

module.exports = BrandControllers;
