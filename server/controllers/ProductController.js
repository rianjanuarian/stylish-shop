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
  credentials: {
    "type": "service_account",
    "project_id": "eastern-dream-272111",
    "private_key_id": "7c8c89da30790dc43d65677a33d2b042d6b3e7b3",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCYjGhb4OdDgM5g\nJSToOdUyJ5OQqgjYKtoGXMHjGkHh/9NEd0EzoIRcx/E8rE4lFxHIt3yIbRq9WbS7\nyv+GShmCBd95cPrqnblT5tfQu7XZiqPWqnGRNQyWcG4EV80DdgpO0muLkkPaP2Su\n/q0HdstQVtX47J3xlqrvQhuf4Rm863pvH/tRTKcsHPS5jXtIX4Vc0qPGp0kwNxUz\n5PMuX2QaJtDN7G9l1Orvr/88CLzuyEYMsYC1O4Nm2tgOPg25MT3UZUxkZFPC73Fz\nHvQOOpffKNzPfI97wdRAZQ+XehJ1JstInhJ5oP3cgvFhu5MQ9k8JX2w2nZVEBJPM\n40ndIxL3AgMBAAECggEADxLwzQNwVs9HlWCWQQxV8NrQTh8/OH0jhjVsQ1C46egp\nrD5Mhxl5euGXCPPN1QRukXLwL1r4pXVT0qrAjTiNRLfn2Uw8vypOweexs8KYuaJl\nhjTZfAvN7p+1f2BdtdXYNum8DtKpOcvB2zj3SCGI/atXAX4ALXtB8NqLeET6Ehzb\nlHoEbsq/oUKD9jf1oKod5kdJ2ciQ/ac49ciBScg53rFx9B4/BwFT0k4Yp2rHBFkh\nzjgx8rU71uXLA9PCaufUkZ6p149sbOm7EdVdMBDRZV2waJvxW6vL/WLp7ooftLdC\nRNxa9kFxtRTywPHA+136slQA729IhUPJeY4UPOrjgQKBgQDVcbZKLL0p11HKCf2K\nLAMygm/xgZFVHbgiXfkAHxv8n2ywtrDHEQegBl2pSVN/4D17HWxSipw/4EmO1+kM\nA/eDlda22SWSmzw8SSWKbjIcdVYayvjF95IJBBa9BuE2pvXDFvDGy0OWSwNvZzCb\nfjr8LCdkM7ifcaGxaNbj3vw+ZwKBgQC29ozq01Fo7uDH/QuZfIJUay24ZO5QK3iF\nN5VVy69qXkrIHOrkDVEODIHQRmCL/pDf1RnZI9ru7M7gyZelQlcAPDcp7s/pTgnc\nAA4B1yN2lVfTovB/X0xtbBorSwVmXc64Vmpqul245sd1unu2EPRTApZNIgksCT4X\nd4PeNJSM8QKBgDzLrduE0MCZNw+wNspjbOm3I4GLoUS4OVl4oNL7CXK0SjYvYzzg\nSea3yXfNjf4PdhOaNt9v4b+D+A+6ygOFIbwWMtlUEpKmqsqVHx9F8foPJd5tz9w7\nfxoYUw22ZvG1Lq1J3H0TKoYlia3ym3K+yrhHL1UoMj8gE6k/rm2rdvejAoGAFDCg\n3Ej1ct7pbyg9X3Kd7zLkmLSKl840Pn8ju5P+h35gQjTutrvBdgtrR9B8VvaAhjK9\n53hNcJAxRBz63wGzGBONAtOXnec+r0hSQ2G6SBuy1WfloiiiBnEnch+VOPahGTZw\nB9cJAJ525Ebv3+d/Dqn6bAiVeoaKk4xcwOiMfAECgYEAjjGx7wnAmo+Dq2vmYCKL\n+Ls0xDQVB91EGkcB+jrg18dgjkCwmbfikL2zLyy4GMbc8NvrBXjPQF7jgvh4WIPo\niB+Jd3Iz2OHzUUjwitSlwKouHBi+sSz42FjS0BuBqLRJgqwnINcqeSUTA2CGANIV\nT3ut7QRUWnML5MEfpThILrk=\n-----END PRIVATE KEY-----\n",
    "client_email": "rianjanuarian@eastern-dream-272111.iam.gserviceaccount.com",
    "client_id": "115909661453997430090",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/rianjanuarian%40eastern-dream-272111.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
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
