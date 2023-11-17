import axios from "axios";

const cartApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/carts",
});

export default cartApi;
