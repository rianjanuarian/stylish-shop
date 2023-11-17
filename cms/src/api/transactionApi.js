import axios from "axios";

const transactionApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/transactions",
});

export default transactionApi;
