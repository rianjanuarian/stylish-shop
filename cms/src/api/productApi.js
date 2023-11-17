import axios from "axios";

const productApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/products",
});

export default productApi;
