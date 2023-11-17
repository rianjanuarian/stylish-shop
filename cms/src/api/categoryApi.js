import axios from "axios";

const categoryApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/categories",
});

export default categoryApi;
