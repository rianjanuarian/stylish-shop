const transactionRoutes = require("express").Router();
const { verifyUser } = require("../middlewares/verifyRole");
const TransactionControllers = require("../controllers/TransactionController");

transactionRoutes.get("/approve", verifyUser, TransactionControllers.updateStatus);
transactionRoutes.get("/", TransactionControllers.getTransaction);
transactionRoutes.get("/transaction-user",  verifyUser, TransactionControllers.getTransactionByUser);
transactionRoutes.get(
  "/:id",
  verifyUser,
  TransactionControllers.getTransactionDetail
);
transactionRoutes.post(
  "/create/:id",
  verifyUser,
  TransactionControllers.createTransaction
);

module.exports = transactionRoutes;
