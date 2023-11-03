import axios from "axios";

const transactionApi = axios.create({
  baseURL: "http://localhost:3000/transactions",
});

export default transactionApi;
