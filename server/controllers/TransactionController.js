const { transaction, product, cart } = require("../models");
const CartController = require("./CartController");

class TransactionControllers {
  static async createTransaction(req, res, next) {
    try {
      const id = req.params.id; //get cart by sending it from cart page to transaction
      const products = await cart.findByPk(id, { include: [product] });
      //harus bkin kolom alamat? soalnya kan ada desain alamat
      //harus dpetin midtrans jg
      // keknya ini kita bkin klo ada bayangan gmana midtrans ga si?
      await cart.destroy({
        where: {
          id,
        },
      });
      res.status(200).json(products);
    } catch (error) {
      next(error);
    }
    c;
  }
}

module.exports = TransactionControllers;
