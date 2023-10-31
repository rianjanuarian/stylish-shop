const createError = require("../middlewares/createError");
const {
  product,
  category,
  brand,
  categoryproduct,
  brandproduct,
} = require("../models");

const { Op } = require("sequelize");

class ProductControllers {
  static async getData(req, res, next) {
    try {
      const result = await product.findAll({
        include: [category, brand],
      });
      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  static async create(req, res, next) {
    try {
      let { categoryId, brandId, ...otherDetails } = req.body;

      const product = await product.create({
        ...otherDetails,
      });

      await categoryproduct.create({
        productId: parseInt(product.id),
        categoryId: parseInt(categoryId),
      });

      await brandproduct.create({
        productId: parseInt(product.id),
        brandId: parseInt(brandId),
      });

      res.status(201).json({ message: "Success adding new product!" });
    } catch (error) {
      next(error);
    }
  }

  static async delete(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      let result = await product.destroy({
        where: { id },
      });

      result === 1
        ? res
            .status(200)
            .json({ message: "Product has been deleted successfully!" })
        : next(createError(400, "Product cannot be deleted!"));
    } catch (error) {
      next(error);
    }
  }

  static async update(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      let result = await product.update(req.body, {
        where: { id },
      });

      result[0] === 1
        ? res
            .status(200)
            .json({ message: "Product has been updated successfully!" })
        : next(createError(400, "Product cannot be updated!"));
    } catch (error) {
      next(error);
    }
  }

  static async detail(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      let result = await product.findByPk(id, {
        include: [category, brand],
      });

      if (!result) {
        return next(createError(404, "Product not found!"));
      }

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  static async getProductsByCategories(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      let result = await category.findByPk(id, {
        include: [product],
      });

      if (!result) {
        return next(createError(404, "Products not found!"));
      }

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  static async getProductsByBrands(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      let result = await brand.findByPk(id, {
        include: [product],
      });

      if (!result) {
        return next(createError(404, "Products not found!"));
      }

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }

  static async getProductsBySearch(req, res, next) {
    try {
      const { name } = req.query;

      let result = await product.findAll({
        include: [category, brand],
        where: {
          name: {
            [Op.iLike]: `%${name}%`,
          },
        },
      });

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }
  static async getProductsBycategorySearch(req, res, next) {
    try {
      const { categories } = req.query;
      let result = await category.findAll({
        include: [product],
        where: {
          name: {
            [Op.iLike]: `%${categories}%`,
          },
        },
      });

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }
  static async getProductsBybrandSearch(req, res, next) {
    try {
      const { brands } = req.query;
      let result = await brand.findAll({
        include: [product],
        where: {
          name: {
            [Op.iLike]: `%${brands}%`,
          },
        },
      });

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }
}

module.exports = ProductControllers;
