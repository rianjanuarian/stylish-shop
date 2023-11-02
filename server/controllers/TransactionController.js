const { transaction, product, cart } = require("../models");
const midtransClient = require("midtrans-client");

class TransactionControllers {
  static async createTransaction(req, res, next) {
    // try {
    //   const id = req.params.id;
    //   const products = await cart.findByPk(id, { include: [product] });
    //   await cart.destroy({
    //     where: {
    //       id,
    //     },
    //   });
    //   res.status(200).json(products);
    // } catch (error) {
    //   next(error);
    // }
    try {
      const id = req.user.dataValues.id;
      const carts = await cart.findOne({
        where: {
          userId: id,
        },
      });
      return;
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
          gross_amount: sumPay(getPriceEvent.price, arrSeat.length), // Jumlah yang akan di bayar
        },
        credit_card: {
          // by defaulting
          secure: true,
        },
        customer_details: {
          first_name: "budi",
          last_name: "pratama",
          email: "budi.pra@example.com",
          phone: "08111222333",
        },
      };

      const transaction = await snap.createTransaction(parameter);
      let transactionToken = transaction.token; //ambil token dari midtrands

      let userPay = await payment.create({
        //create payment
        userId: +id,
        eventId: +idEvent,
        seatId: arrSeat,
        orderId: idOrder,
        total_ticket: arrSeat.length,
        midtransToken: transactionToken,
      });

      await cart.destroy({
        where: {
          userId: id,
        },
      });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = TransactionControllers;
