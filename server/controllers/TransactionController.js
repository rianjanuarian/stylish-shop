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
            req.user.name.toLowerCase === "user"
              ? "User"
              : req.user.name.split(" ")[0]
          }`,
          last_name: `${
            req.user.name.toLowerCase === "user"
              ? ""
              : req.user.name.split(" ")[1]
          }`,
          email: `${req.user.email}`,
          phone: `${req.user.phone_number}`,
        },
      };

      const transactions = await snap.createTransaction(parameter);
      let transactionToken = transactions.token; //ambil token dari midtrands

      if (arrCart.length === 0) {
        return next(createError(404, "Cart is empty!"));
      }

      let userPay = await transaction.create({
        //create payment
        userId: userId,
        orderId: orderId,
        cartId: arrCart.toString(),
        courierId: idCourier,
        midtranstoken: transactionToken,
        status: "pending",
      });
      //izin mindahin cuma klo pembayaran sukses, nyusahin buat development klo ga
      // await cart.destroy({
      //   where: {
      //     userId: userId,
      //   },
      // });

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
      if (statusOrder === "approve") {
        const userId = req.user.id;
        const carts = await cart.findAll({ where: { userId } });
        //hasilnya kan list si cart. nah liat product id dri si itu, terus kurangin jumlah qty,
        // ini baru keknya loh aku blom tes, jam 1 ngantuk
        // btw klo quantity ini coba aja dulu, klo work comment lagi aja, soalnya kan kita msih butuh buat development, klo abis barang nnti kita g bsa test2 transaction lagi
        // tidor dulu
        for (const cartItem of carts) {
          const { productId, qty } = cartItem;
          const product = await product.findByPk(productId);
          if (product) {
            const updatedQty = product.qty - qty;
            await product.update({ qty: updatedQty });
          }
        }
        await cart.destroy({
          where: {
            userId,
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
