const { category } = require("../models");

class CategorysControllers {
  static async getCategories(req, res) {
    try {
      const categories = await category.findAll();
      res.status(200).json(categories);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static async create(req, res) {
    try {
      const { name, image } = req.body;
      const category = await category.create({ name, image });
      res.status(200).json(category);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static async update(req, res) {
    try {
      const { id } = req.params;
      const { name, image } = req.body;
      const category = await category.update(
        { name, image },
        { where: { id } }
      );
      res.status(200).json(category);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }

  static async delete(req, res) {
    try {
      const { id } = req.params;
      const category = await category.destroy({ where: { id } });
      res.status(200).json(category);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  }
}

module.exports = CategorysControllers;
