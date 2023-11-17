import axios from "axios";

const brandApi = axios.create({
 // http://localhost:3000/brands"
  baseURL: "https://stylish-shop.vercel.app/brands",
});

export default brandApi;
