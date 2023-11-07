import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import { productApi } from "../api";

const accessToken = localStorage.getItem("Authorization");
const config = {
  headers: {
    "Content-Type": "multipart/form-data",
    Authorization: `Bearer ${accessToken}`,
  },

  withCredentials: true,
};

export const getProducts = createAsyncThunk(
  "products/getProducts",
  async () => {
    try {
      const response = await productApi.get("/");
      return response.data;
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const saveProduct = createAsyncThunk(
  "products/saveProducts",
  async ({
    name,
    price,
    description,
    stock,
    image,
    colors,
    categoryId,
    brandId,
  }) => {
    try {
      const colorsString = colors.join(",");
      const formData = new FormData();
      formData.append("images", image);
      formData.append("name", name);
      formData.append("price", price);
      formData.append("description", description);
      formData.append("stock", stock);
      formData.append("colors", colorsString);
      formData.append("categoryId", categoryId);
      formData.append("brandId", brandId);

      const response = await productApi.post("/create", formData, config);
      return response.data;
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const deleteProduct = createAsyncThunk(
  "products/deleteProducts",
  async (id) => {
    try {
      const response = await productApi.delete(`/delete/${id}`, config);
      return { id, message: response.data.message };
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const updateProduct = createAsyncThunk(
  "products/updateProducts",
  async ({
    id,
    name,
    price,
    description,
    stock,
    image,
    colors,
    categoryId,
    brandId,
  }) => {
    try {
      const colorsString = colors.join(",");
      const formData = new FormData();
      formData.append("images", image);
      formData.append("name", name);
      formData.append("price", price);
      formData.append("description", description);
      formData.append("stock", stock);
      formData.append("colors", colorsString);
      formData.append("categoryId", categoryId);
      formData.append("brandId", brandId);
      const response = await productApi.put(`/update/${id}`, formData, config);
      return { id, message: response.data.message, data: response.data.data };
    } catch (error) {
      throw error.response.data;
    }
  }
);
const productEntity = createEntityAdapter({
  selectId: (products) => products.id,
});

const productSlice = createSlice({
  name: "products",
  initialState: productEntity.getInitialState(),
  extraReducers: (builder) => {
    builder
      .addCase(getProducts.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getProducts.fulfilled, (state, action) => {
        state.loading = false;
        state.error = null;
        productEntity.setAll(state, action.payload);
      })
      .addCase(getProducts.rejected, (state, action) => {
        state.loading = false;
        state.error =
          action.error.message || "An error occurred. Please try again.";
      });
    //add
    builder.addCase(saveProduct.fulfilled, (state, action) => {
      productEntity.addOne(state, action.payload.newProduct);
    });
    //delete
    builder.addCase(deleteProduct.fulfilled, (state, action) => {
      productEntity.removeOne(state, action.payload.id);
    });
    //update
    builder.addCase(updateProduct.fulfilled, (state, action) => {
      console.log(action.payload.data);
      productEntity.updateOne(state, {
        id: action.payload.id,
        changes: action.payload.data,
      });
    });
  },
});

export const { selectAll: selectAllProducts, selectById: selectProductById } =
  productEntity.getSelectors((state) => state.products);
export default productSlice.reducer;
