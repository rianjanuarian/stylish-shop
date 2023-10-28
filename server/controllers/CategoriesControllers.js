const { category } = require("../models");

class CategorysControllers {
  static async getCategories(req, res, next) {
    try {
      const categories = await category.findAll();
      res.status(200).json(categories);
    } catch (err) {
      next(err);
    }
  }

  static async create(req, res, next) {
    try {
      const { name, image } = req.body;
      const category = await category.create({ name, image });
      res.status(200).json(category);
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const { id } = req.params;
      const { name, image } = req.body;
      const category = await category.update(
        { name, image },
        { where: { id } }
      );
      res.status(200).json(category);
    } catch (err) {
      next(err);
    }
  }

  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const category = await category.destroy({ where: { id } });
      res.status(200).json(category);
    } catch (err) {
      next(err);
    }
  }
}

module.exports = CategorysControllers;
