import { configureStore } from "@reduxjs/toolkit";
import productReducer from "../redux/productSlice";
import brandReducer from "../redux/brandSlice";
import categorySlice from "../redux/categorySlice";
import authReducer from "../redux/authSlice";
import userReducer from "../redux/userSlice";
import courierReducer from "../redux/courierSlice";



export const store = configureStore({
  reducer: {
    auth: authReducer,
    products: productReducer,
    brands: brandReducer,
    categories: categorySlice,
    users: userReducer,
    couriers: courierReducer,
  },
});
