const { brand } = require("../models");

class BrandControllers {
  static async getBrands(req, res, next) {
    try {
      const brands = await brand.findAll();
      res.status(200).json(brands);
    } catch (err) {
      next(err)
    }
  }

  static async create(req, res, next) {
    try {
      const { name, image } = req.body;
      const brand = await brand.create({ name, image });
      res.status(200).json(brand);
    } catch (err) {
      next(err)
    }
  }
  static async update(req, res, next) {
    try {
      const { id } = req.params;
      const { name, image } = req.body;
      const brand = await brand.update({ name, image }, { where: { id } });
      res.status(200).json(brand);
    } catch (err) {
      next(err)
    }
  }
  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const brand = await brand.destroy({ where: { id } });
      res.status(200).json(brand);
    } catch (err) {
      next(err)
    }
  }
}

module.exports = BrandControllers;
