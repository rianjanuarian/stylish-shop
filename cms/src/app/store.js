import { configureStore } from "@reduxjs/toolkit";
import productReducer from "../redux/productSlice";
import brandReducer from "../redux/brandSlice";
import categorySlice from "../redux/categorySlice";
import authReducer from "../redux/authSlice";
import brandTestReducer from "../redux/brandSliceTest";
import categoryTestReducer from "../redux/categorySliceTest";

export const store = configureStore({
  reducer: {
    products: productReducer,
    brands: brandReducer,
    categories: categorySlice,
    auth: authReducer,
    brandTest: brandTestReducer,
    categoryTest: categoryTestReducer,
  },
});
