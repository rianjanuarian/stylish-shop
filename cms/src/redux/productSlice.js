import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import axios from "axios";

export const getProducts = createAsyncThunk(
  "products/getProducts",
  async () => {
    const response = await axios.get("http://localhost:3000/products");
    return response.data;
  }
);
export const saveProducts = createAsyncThunk(
  "products/saveProducts",
  async ({
    name,
    price,
    description,
    stock,
    image,
    color,
    categoryId,
    brandId,
  }) => {
    const formData = new FormData();
    formData.append("images", image);
    formData.append("name", name);
    formData.append("price", price);
    formData.append("description", description);
    formData.append("stock", stock);
    formData.append("color", color);
    formData.append("categoryId", categoryId);
    formData.append("brandId", brandId); 
  
    const response = await axios.post("http://localhost:3000/products/create", formData);
    return response.data;
  }
);

export const deleteProducts = createAsyncThunk(
  "products/deleteProducts",
  async (id) => {
    await axios.delete(`http://localhost:3000/products/delete/${id}`);
    return id;
  }
);

export const updateProducts = createAsyncThunk(
  "products/updateProducts",
  async ({
    id,
    name,
    price,
    description,
    stock,
    image,
    color,
    categoryId,
    brandId,
  }) => {
    const formData = new FormData();
    formData.append("images", image);
    formData.append("name", name);
    formData.append("price", price);
    formData.append("description", description);
    formData.append("stock", stock);
    formData.append("color", color);
    formData.append("categoryId", categoryId);
    formData.append("brandId", brandId); 
    const response = await axios.put(
      `http://localhost:3000/products/update/${id}`,
      formData
    );
    return response.data;
  }
);
const productEntity = createEntityAdapter({
  selectId: (products) => products.id,
});

const productSlice = createSlice({
  name: "products",
  initialState: productEntity.getInitialState(),
  extraReducers: {
    [getProducts.pending]: (state) => {
      state.status = "loading";

    },
    [getProducts.fulfilled]: (state, action) => {
      state.status = "success";
      productEntity.setAll(state, action.payload);
    },
    [getProducts.rejected]: (state, action) => {
      state.status = "rejected";
      state.error = action.error.message;
    },
    [saveProducts.fulfilled]: (state, action) => {
      productEntity.addOne(state, action.payload);
    },
    [deleteProducts.fulfilled]: (state, action) => {
      productEntity.removeOne(state, action.payload);
    },
    [updateProducts.fulfilled]: (state, action) => {
      productEntity.updateOne(state, {
        id: action.payload.id,
        updates: action.payload,
      });
    },
  },
});

export const productSelectors = productEntity.getSelectors(
  (state) => state.products
);
export default productSlice.reducer;
