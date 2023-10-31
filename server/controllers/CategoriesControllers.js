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
      const { name } = req.body;
      const categories = await category.create({ name });
      res
        .status(201)
        .json({ message: "Category has been created!", categories });
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const { id } = req.params;
      const { name } = req.body;
      const categories = await category.update({ name }, { where: { id } });
      categories[0] === 1
        ? res.status(200).json({ message: "Category has been updated!" })
        : res.status(404).json({ message: "Category not found!" });
    } catch (err) {
      next(err);
    }
  }

  static async delete(req, res, next) {
    try {
      const { id } = req.params;
      const categories = await category.destroy({ where: { id } });
      categories === 1
        ? res.status(200).json({ message: "Category has been deleted!" })
        : res.status(404).json({ message: "Category not found!" });
    } catch (err) {
      next(err);
    }
  }
}

module.exports = CategorysControllers;
