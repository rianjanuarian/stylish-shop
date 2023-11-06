const createError = require("../middlewares/createError");
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

      const { name } = req.body;
      const newBrand = await brand.create({ name, image: req.file.filename });
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

      const updatedData = {
        name: req.body.name,
        image: req.file.filename,
      };
      const response = await currentBrand.update(updatedData);
      console.log(response);
      response.dataValues
        ? res.status(200).json({ message: "Brand has been updated!" })
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
