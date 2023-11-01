const createError = require("../middlewares/createError");
const { cart, product } = require("../models");

class CartController {
  static async create(req, res, next) {
    try {
      const { productId } = req.body;
      const userId = req.user.dataValues.id;

      const currentProduct = await product.findByPk(productId);

      if (!currentProduct) {
        return next(createError(404, "Product not found!"));
      }

      const total_price = currentProduct.dataValues.price;

      let result = await cart.create({
        productId,
        userId,
        total_price,
      });
      res.status(201).json(result);
    } catch (error) {
      next(error);
    }
  }

  static async getProductsByUserId(req, res, next) {
    try {
      const userId = req.user.dataValues.id;
      const products = await cart.findAll({
        where: {
          userId,
        },
      });
      res.status(200).json(products);
    } catch (error) {
      next(error);
    }
  }

  static async update(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const { qty } = req.body;

      const currentCart = await cart.findByPk(id);
      const userId = req.user.dataValues.id;

      if (!currentCart) {
        return next(createError(404, "Cart not found!"));
      }

      if (userId !== currentCart.userId) {
        return next(
          createError(401, "You are not authorized to update this cart!")
        );
      }

      const currentProduct = await product.findByPk(
        currentCart.dataValues.productId
      );

      const total_price = currentProduct.price * qty;

      await currentCart.update({
        qty,
        total_price,
      });

      res.status(201).json({ message: "cart successfully updated" });
    } catch (error) {
      next(error);
    }
  }

  static async delete(req, res, next) {
    try {
      // const id = parseInt(req.params.id);
      const productId = parseInt(req.params.id); //penggantian variable
      const userId = req.user.dataValues.id;
      // let currentCart = await cart.findByPk(id);
      let currentCart = await cart.findOne({
        where: {
          productId,
          userId,
        },
      }); //Penghapusan dari productId ~Indra Oki Sandy~

      if (!currentCart) {
        return next(createError(404, "Cart not found!"));
      }

      if (currentCart.userId !== userId) {
        return next(
          createError(401, "You are not authorized to delete this cart!")
        );
      } //harusnya ini nggak usah sih, karena penghapusan dari productId, but don't know you thinking ~Indra Oki Sandy~

      await currentCart.destroy();

      res.status(200).json({ message: "Deleted Successfully" });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = CartController;
