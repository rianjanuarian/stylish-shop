import axios from "axios";

const brandApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/brands",
});

export default brandApi;
