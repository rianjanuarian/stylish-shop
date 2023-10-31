const { brand } = require("../models");

class BrandControllers {
  static async getBrands(req, res, next) {
    try {
      const brands = await brand.findAll();
      res.status(200).json(brands);
    } catch (err) {
      next(err);
    }
  }

  static async create(req, res, next) {
    try {
      const { name, image } = req.body;
      const brands = await brand.create({ name, image });
      res.status(201).json({ message: "Brand has been created!", brands });
    } catch (err) {
      next(err);
    }
  }
  static async update(req, res, next) {
    try {
      const { id } = req.params;
      const { name, image } = req.body;
      const brands = await brand.update({ name, image }, { where: { id } });
      brands[0] === 1
        ? res.status(200).json({ message: "Brand has been updated!" })
        : res.status(404).json({ message: "Brand not found!" });
    } catch (err) {
      next(err);
    }
  }
  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const brands = await brand.destroy({ where: { id } });
      brands === 1
        ? res.status(200).json({ message: "Brand has been deleted!" })
        : res.status(404).json({ message: "Brand not found!" });
    } catch (err) {
      next(err);
    }
  }
}

module.exports = BrandControllers;
