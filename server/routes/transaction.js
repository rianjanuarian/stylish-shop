const transactionRoutes = require("express").Router();
const { verifyUser } = require("../middlewares/verifyRole");
const TransactionControllers = require("../controllers/TransactionController");

// transactionRoutes.get("/approve", TransactionControllers.updateStatus);
// transactionRoutes.get("/", TransactionControllers.getTransaction);
// transactionRoutes.get("/:id", TransactionControllers.getTransactionDetail);
transactionRoutes.post(
  "/create",
  verifyUser,
  TransactionControllers.createTransaction
);

module.exports = transactionRoutes;
