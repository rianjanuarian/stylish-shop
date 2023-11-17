const createError = require("../middlewares/createError");
const {
  product,
  category,
  brand,
  categoryproduct,
  brandproduct,
} = require("../models");
const { Storage } = require('@google-cloud/storage');
const storage = new Storage({
  projectId: '7c8c89da30790dc43d65677a33d2b042d6b3e7b3',
  credentials: require("../helpers/cloud-storage.json")
});
const { Op } = require("sequelize");

class ProductControllers {
  static async getProducts(req, res, next) {
    try {
      const result = await product.findAll({
        include: [category, brand],
      });
      res.status(200).json(result);
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

  //only admin can access part


  static async create(req, res, next) {
    try {
      const bucketName = 'stylish-shop';
      const destination = `products/${req.file.filename}`;
      let { categoryId, brandId, colors, ...otherDetails } = req.body;
      categoryId = parseInt(categoryId);
      brandId = parseInt(brandId);

      colors = colors.split(",");
      await storage.bucket(bucketName).upload(req.file.path, {destination,});
      const image = req.file
        ? `${bucketName}/${destination}`
        : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png";

      const newProduct = await product.create({
        colors,
        ...otherDetails,
        image,
      });

      const isCategoryExist = await category.findByPk(categoryId);
      const isBrandExist = await brand.findByPk(brandId);

      if (!isCategoryExist) {
        return next(createError(400, "Category does not exist!"));
      }

      if (!isBrandExist) {
        return next(createError(400, "Brand does not exist!"));
      }

      await categoryproduct.create({
        productId: parseInt(newProduct.dataValues.id),
        categoryId: parseInt(categoryId),
      });

      await brandproduct.create({
        productId: parseInt(newProduct.dataValues.id),
        brandId: parseInt(brandId),
      });

      const result = await product.findByPk(newProduct.id, {
        include: [category, brand],
      });

      res
        .status(201)
        .json({ message: "Success adding new product!", newProduct: result });
    } catch (error) {
      next(error);
    }
  }

  static async update(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const bucketName = 'stylish-shop';
      const destination = `products/${req.file.filename}`;
      let { categoryId, brandId, colors, ...otherDetails } = req.body;

      colors = colors.split(",");

      const currentProduct = await product.findByPk(id);

      if (!currentProduct) {
        return next(createError(404, "Product not found!"));
      }
      await storage.bucket(bucketName).upload(req.file.path, {destination,});
      const image = req.file
        ? `${bucketName}/${destination}`
        : currentProduct.dataValues.image;

      const updatedData = {
        colors,
        ...otherDetails,
        image,
      };

      await currentProduct.update(updatedData);

      await categoryproduct.update(
        { categoryId },
        { where: { productId: currentProduct.id } }
      );
      await brandproduct.update(
        { brandId },
        { where: { productId: currentProduct.id } }
      );

      const result = await product.findByPk(currentProduct.id, {
        include: [category, brand],
      });

      res.status(200).json({
        message: "Product has been updated successfully!",
        data: result.dataValues,
      });
    } catch (error) {
      next(error);
    }
  }

  static async delete(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const currentProduct = await product.findByPk(id);

      if (!currentProduct) {
        return next(createError(404, "Product not found!"));
      }

      await categoryproduct.destroy({
        where: { productId: currentProduct.id },
      });
      await brandproduct.destroy({
        where: { productId: currentProduct.id },
      });
      await product.destroy({
        where: { id },
      });

      res
        .status(200)
        .json({ message: "Product has been deleted successfully!" });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = ProductControllers;
