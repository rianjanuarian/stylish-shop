import axios from "axios";

const reviewApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/reviews",
});

export default reviewApi;
