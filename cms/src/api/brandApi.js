import axios from "axios";

const brandApi = axios.create({
  baseURL: "http://localhost:3000/brands",
});

export default brandApi;
