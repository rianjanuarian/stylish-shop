import axios from "axios";

const brandApi = axios.create({

//  baseURL: "http://localhost:3000/brands",
  baseURL: "https://stylish-shop.vercel.app/brands",
});

export default brandApi;
