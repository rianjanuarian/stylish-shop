const transactionRoutes = require("express").Router();
const TransactionControllers = require("../controllers/TransactionController");

transactionRoutes.get("/approve", TransactionControllers.updateStatus);
transactionRoutes.get("/", TransactionControllers.getTransaction);
transactionRoutes.get("/:id", TransactionControllers.getTransactionDetail);
transactionRoutes.post("/create", TransactionControllers.createTransaction);

module.exports = transactionRoutes;
