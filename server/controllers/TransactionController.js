const { transaction, cart, courier, user, product } = require("../models");
const midtransClient = require("midtrans-client");
const { createOrder } = require("../helpers/order");
const createError = require("../middlewares/createError");

class TransactionControllers {
  static async getTransaction(req, res, next) {
    try {
      const transactions = await transaction.findAll({
        include: [user, courier],
      });
      res.status(200).json(transactions);
    } catch (error) {
      next(error);
    }
  }

  static async getTransactionByUser(req, res, next) {
    try {
      const userId = req.user.id;
      const transactions = await transaction.findAll({
        where: {
          userId,
        },
      });
      res.status(200).json(transactions);
    } catch (error) {
      next(error);
    }
  }

  static async getTransactionDetail(req, res, next) {
    try {
      const id = req.params.id;
      const userId = req.user.dataValues.id;
      const userPay = await transaction.findByPk(id);

      if (!userPay) {
        return next(createError(404, "Transaction not found!"));
      }
      if (userId !== userPay.userId) {
        return next(createError(401, "You are not authorized!"));
      }

      res.status(200).json({
        userPay,
        redirect_url: `https://app.sandbox.midtrans.com/snap/v3/redirection/${userPay.midtranstoken}`,
      });
    } catch (error) {
      next(error);
    }
  }

  static async createTransaction(req, res, next) {
    try {
      const userId = req.user.id;
      const idCourier = +req.params.id;
      const carts = await cart.findAll({
        where: {
          userId: userId,
        },
        include: [product],
      });

      const cartIds = carts.map((cart) => cart.dataValues.id);
      const getCourier = await courier.findByPk(idCourier);

      const total_price =
        carts
          .map((cart) => cart.dataValues.total_price)
          .reduce((a, b) => a + b, 0) + getCourier.price;

      // Untuk mempersingkat waktu, ini tidak usah dulu
      // const itemDetails = carts.map((cartItem) => {
      //   const productDetails = cartItem.product;
      //   return {
      //     id: productDetails.id,
      //     price: productDetails.price,
      //     name: productDetails.name,
      //     quantity: cartItem.qty,
      //   };
      // });

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
            req.user.name.toLowerCase === "user"
              ? "User"
              : req.user.name.split(" ")[0]
          }`,
          last_name: `${
            req.user.name.toLowerCase === "user"
              ? ""
              : req.user.name.split(" ").length > 1
              ? req.user.name.split(" ")[1]
              : ""
          }`,
          email: `${req.user.email}`,
          phone: `${req.user.phone_number}`,
        },
        // Untuk mempersingkat waktu, ini tidak usah dulu
        // item_details: itemDetails,
      };

      const transactions = await snap.createTransaction(parameter);
      let transactionToken = transactions.token; //ambil token dari midtrands

      if (cartIds.length === 0) {
        return next(createError(404, "Cart is empty!"));
      }

      let userPay = await transaction.create({
        //create payment
        userId: userId,
        orderId: orderId,
        cartId: cartIds.toString(),
        courierId: idCourier,
        midtranstoken: transactionToken,
        status: "pending",
      });
      // fungsi hapus
      await cart.update(
        { status: "inactive" },
        {
          where: {
            userId: userId,
          },
        }
      );

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

      //ini g tau bsa apa ga, tolong setel lah
      if (transaction_status === "approve") {
        const userId = req.user.id;
        const carts = await cart.findAll({ where: { userId } });

        for (const cartItem of carts) {
          const { productId, qty } = cartItem;
          const currentProduct = await product.findByPk(productId);
          if (currentProduct) {
            const updatedQty = currentProduct.qty - qty;
            await currentProduct.update({ qty: updatedQty });
          }
        }
        await cart.destroy({
          where: {
            userId: userId,
          },
        });
      }

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
