const createError = require("../middlewares/createError");
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
  a;
  static async create(req, res, next) {
    try {
      const { name } = req.body;
      const newCategory = await category.create({ name });
      res
        .status(201)
        .json({ message: "Category has been created!", newCategory });
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const currentCategory = await category.findByPk(id);

      if (!currentCategory) {
        return next(createError(404, "Category does not exist!"));
      }

      const response = await currentCategory.update(req.body);
      response.dataValues
        ? res
            .status(200)
            .json({
              message: "Category has been updated!",
              data: response.dataValues,
            })
        : next(createError(400, "Brand has not been updated!"));
    } catch (err) {
      next(err);
    }
  }

  static async delete(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const currentCategory = await category.findByPk(id);

      if (!currentCategory) {
        return next(createError(404, "Category does not exist!"));
      }

      await currentCategory.destroy();
      res.status(200).json({ message: "Category has been deleted!" });
    } catch (err) {
      next(err);
    }
  }
}

module.exports = CategorysControllers;
