import { configureStore } from "@reduxjs/toolkit";
import productReducer from "../redux/productSlice";
import brandReducer from "../redux/brandSlice";
import categorySlice from "../redux/categorySlice";
import authReducer from "../redux/authSlice";
import userSlice from "../redux/userSlice";

export const store = configureStore({
  reducer: {
    products: productReducer,
    brands: brandReducer,
    categories: categorySlice,
    auth: authReducer,
    users : userSlice,
  },
});
