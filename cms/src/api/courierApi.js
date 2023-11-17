import axios from "axios";

const courierApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/couriers",
});

export default courierApi;
