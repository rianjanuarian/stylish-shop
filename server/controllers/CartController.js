const createError = require("../middlewares/createError");
const { cart, user, product } = require("../models");

//ini harus bkin ulang :") tpi ngantuk
class CartController {
  static async create(req, res, next) {
    try {
      const { productId, userId, qty, total_price } = req.body;
      let result = await cart.create({
        productId,
        userId,
        qty, 
        total_price, // salah aku, hrusnya g ada total_price disni tpi di transaction saja, dsni hrus math aja di fe, krna harga blom pasti bsa berubah klo qty berubah
      });
      res.status(201).json(result);
    } catch (error) {
      next(error);
    }
  }

  static async getProductsByUserId(req, res, next) { //bsok lah aku bkin
    try {
      const userId = req.user.id;
      const products = await cart.findAll({
        where: {
          userId
        }, 
      });
      res.status(200).json(products);
    } catch (error) {
      next(error);
    }
  }

  static async getProductForTransaction(req, res, next) { //bsok aku kerjain jg
    try {
      const userId = req.user.id;
      const products = await cart.findAll({
        where: {
          userId
        }, 
      }); 
      //blom fix
      return products;
    } catch (error) {
      next(error);
    }
  }

  static async update(req, res, next) { //y diupdate hrusnya cuma qty y lain g bsa
    try {
      const id = +req.params.id;
      const { productId, userId, qty, total_price } = req.body;
      let result = await cart.update(
        {
          productId,
          userId,
          qty,
          total_price,
        },
        { where: { id } }
      );
      if (result[0] === 1) {
        res.status(201).json({ message: "cart successfully updated" });
      } else {
        next(createError(400, "Cart cannot created"));
      }
    } catch (error) {
      next(error);
    }
  }

  static async delete(req, res, next) {
    try {
      const id = +req.params.id;
      let result = await cart.destroy({ where: { id } });
      if (result === 1) {
        res.status(200).json({ message: "Deleted Successfully" });
      } else {
        next(createError(400, "Cart cannot deleted"));
      }
    } catch (error) {
      next(error);
    }
  }

  static async getByCart(req, res, next) { //what is dis?
    try {
      const id = +req.params.id;
      let result = await user.findByPk(id, {
        include: [product],
      });

      res.status(200).json(result);
    } catch (error) {
      next(error);
    }
  }
}

module.exports = CartController;
