import axios from "axios";

const categoryApi = axios.create({
  baseURL: "http://localhost:3000/categories",
});

export default categoryApi;
