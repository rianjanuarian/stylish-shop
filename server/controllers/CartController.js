const createError = require("../middlewares/createError");
const { cart, product, user, courier } = require("../models");

class CartController {
  static async create(req, res, next) {
    try {
      const { productId, qty, total_price, color } = req.body;
      console.log(color);

      const userId = req.user.id;

      const currentProduct = await product.findByPk(productId);

      if (!currentProduct) {
        return next(createError(404, "Product not found!"));
      }

      let newCart = await cart.create({
        productId,
        userId,
        qty,
        total_price,
        color,
      });

      res.status(201).json({ message: "Brand has been created!", newCart });
    } catch (error) {
      next(error);
    }
  }

  static async getProductsByUserId(req, res, next) {
    try {
      const userId = req.user.id;
      const products = await cart.findAll({
        where: {
          userId,
        },
        include: [product],
      });
      res.status(200).json(products);
    } catch (error) {
      next(error);
    }
  }

  static async getDetailCart(req, res, next) {
    try {
      const userId = req.user.dataValues.id;
      const courierId = req.params.id;
      const allCart = await cart.findAll({
        where: {
          userId,
        },
        include: [
          {
            model: user,
            attributes: ["name", "email", "address", "phone_number"],
          },
          {
            model: product,
            attributes: ["name", "description", "price", "image"],
          },
        ],
      });
      const getCourier = await courier.findByPk(courierId);
      const allTotal =
        allCart.reduce((a, b) => a + b.total_price, 0) + getCourier.price;

      res.status(200).json({
        allCart,
        allTotal: allTotal,
      });
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
      const id = parseInt(req.params.id);
      const userId = req.user.dataValues.id;
      let currentCart = await cart.findByPk(id);

      if (!currentCart) {
        return next(createError(404, "Cart not found!"));
      }

      if (currentCart.userId !== userId) {
        return next(
          createError(401, "You are not authorized to delete this cart!")
        );
      }

      await currentCart.destroy();

      res.status(200).json({ message: "Deleted Successfully" });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = CartController;
