const { transaction, product, cart } = require("../models");
const midtransClient = require("midtrans-client");

class TransactionControllers {
  static async getTransaction(req, res, next) {
    try {
      const transactions = await transaction.findAll();
      res.status(200).json(transactions);
    } catch (error) {
      next(error);
    }
  }

  static async getTransactionDetail(req, res, next) {
    try {
      const id = req.params.id;
      const userId = req.user.dataValues.id;
      const allTransactions = await transaction.findAll();

      if (allTransactions.forEach((e) => e.dataValues.id !== id)) {
        return next(createError(404, "Transaction not found"));
      }

      if (userId !== userId) {
        return next(createError(401, "You are not authorized!"));
      }

      const userPay = await transaction.findByPk(id);
      res.status(200).json({
        userPay,
        redirect_url: `https://app.sandbox.midtrans.com/snap/v3/redirection/${userPay.dataValues.midtranstoken}`,
      });
    } catch (error) {
      next(error);
    }
  }
  static async createTransaction(req, res, next) {
    try {
      const id = req.user.dataValues.id;
      const idCourier = +req.params.id;
      const carts = await cart.findAll({
        where: {
          userId: id,
        },
      });

      let arrCart = [];
      await carts.map((item) => {
        arrCart.push(item.dataValues.id);
      });

      let priceTotal = [];
      for (let i = 0; i < carts.length; i++) {
        priceTotal.push(carts[i].dataValues.total_price);
      }

      const getCourier = await courier.findByPk(idCourier);

      const total_price =
        priceTotal.reduce((a, b) => a + b, 0) + getCourier.price;

      //Struktur Midtrands
      let snap = new midtransClient.Snap({
        isProduction: false,
        serverKey: "SB-Mid-server-ey22xESu3CwookltwsJIbLDn",
      });

      const orderId = createOrder();
      // parameter dari midtrans

      let parameter = {
        transaction_details: {
          order_id: orderId, //Unique
          gross_amount: total_price, // Jumlah yang akan di bayar
        },
        credit_card: {
          // by defaulting
          secure: true,
        },
        customer_details: {
          first_name: `${
            req.user.dataValues.name.toLowerCase === "user"
              ? "User"
              : req.user.dataValues.name.split(" ")[0]
          }`,
          last_name: `${
            req.user.dataValues.name.toLowerCase === "user"
              ? ""
              : req.user.dataValues.name.split(" ")[1]
          }`,
          email: `${req.user.dataValues.email}`,
          phone: `${req.user.dataValues.phone_number}`,
        },
      };

      const transactions = await snap.createTransaction(parameter);
      let transactionToken = transactions.token; //ambil token dari midtrands

      if (arrCart.length === 0) {
        return next(createError(404, "Cart is empty!"));
      }

      let userPay = await transaction.create({
        //create payment
        userId: id,
        orderId: orderId,
        cartId: arrCart.toString(),
        courierId: idCourier,
        midtranstoken: transactionToken,
        status: "pending",
      });

      await cart.destroy({
        where: {
          userId: id,
        },
      });

      res
        .status(200)
        .json({ message: "Transaction Success Created!", userPay });
    } catch (error) {
      next(error);
    }
  }

  static async updateStatus(req, res, next) {
    try {
      const { order_id, transaction_status } = req.query;

      if (!["settlement", "expire"].includes(transaction_status)) {
        return next(createError(400, "Invalid transaction status!"));
      }

      const statusOrder =
        transaction_status === "settlement" ? "approve" : "reject";

      await transaction.update(
        {
          status: statusOrder,
        },
        {
          where: {
            orderId: order_id,
          },
        }
      );
      res.status(201).json({
        message: `Payment status ${statusOrder}!`,
      });
    } catch (error) {
      next(error);
      console.log(error);
    }
  }
}

module.exports = TransactionControllers;
