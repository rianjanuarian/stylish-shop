import axios from "axios";

const reviewApi = axios.create({
  baseURL: "http://localhost:3000/reviews",
});

export default reviewApi;
