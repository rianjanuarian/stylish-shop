import { configureStore } from '@reduxjs/toolkit';
import productReducer from "../features/productSlice"
import brandReducer from "../features/brandSlice"
import categorySlice from '../features/categorySlice';

export const store = configureStore({
  reducer: {
    products : productReducer,
    brands: brandReducer,
    categories : categorySlice,
  },
});