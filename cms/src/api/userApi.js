import axios from "axios";

const userApi = axios.create({
  baseURL: "https://stylish-shop.vercel.app/users",
});

export default userApi;
