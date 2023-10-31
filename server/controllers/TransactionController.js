const { transaction, product, cart } = require("../models");
const CartController = require("./CartController");

class TransactionControllers {
  static async createTransaction(req, res, next) {
    try {
      const id = req.params.id; 
      const products = await cart.findByPk(id, { include: [product] });
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
