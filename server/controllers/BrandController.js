const createError = require("../middlewares/createError");
const { brand } = require("../models");
const { Storage } = require('@google-cloud/storage');
const storage = new Storage({
  projectId: '7c8c89da30790dc43d65677a33d2b042d6b3e7b3',
  credentials: require("../helpers/cloud-storage.json")
});

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

 
    const bucketName = 'stylish-shop';

    const destination = `brands/${req.file.filename}`;

    await storage.bucket(bucketName).upload(req.file.path, {
      destination,
    });

      const { name } = req.body;
      const newBrand = await brand.create({ name, image: `${bucketName}/${destination}` });
      console.log(req.file);
      res.status(201).json({ message: "Brand has been created!", newBrand });
    } catch (err) {
      next(err);
    }
  }

  static async update(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const currentBrand = await brand.findByPk(id);

      if (!currentBrand) {
        return next(createError(404, "Brand does not exist!"));
      }
      const bucketName = 'stylish-shop';

      const destination = `brands/${req.file.filename}`;
  
      await storage.bucket(bucketName).upload(req.file.path, {
        destination,
      });
      const updatedData = {
        name: req.body.name,
        image: `${bucketName}/${destination}`,
      };
      const response = await currentBrand.update(updatedData);
      response.dataValues
        ? res
            .status(200)
            .json({
              message: "Brand has been updated!",
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
      const currentBrand = await brand.findByPk(id);

      if (!currentBrand) {
        return next(createError(404, "Brand does not exist!"));
      }

      await currentBrand.destroy();
      res.status(200).json({ message: "Brand has been deleted!" });
    } catch (err) {
      next(err);
    }
  }
}

module.exports = BrandControllers;
