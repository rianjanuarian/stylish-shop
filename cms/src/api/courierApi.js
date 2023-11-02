import axios from "axios";

const courierApi = axios.create({
  baseURL: "http://localhost:3000/couriers",
});

export default courierApi;
