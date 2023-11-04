import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { brandApi } from "../api";

const initialState = {
  brands: [],
  brand: null,
  loading: "idle",
  message: null,
  error: null,
};

export const getBrandsTest = createAsyncThunk("/brands", async () => {
  try {
    const response = await brandApi.get("/");
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const createBrand = createAsyncThunk("/create", async (formData) => {
  try {
    const response = await brandApi.post("/create", formData);
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const getOneBrand = createAsyncThunk("/getOneBrand", async (id) => {
  const response = await brandApi.get(`/details/${id}`);
  return response.data;
});

export const updateBrand = createAsyncThunk(
  "/update",
  async ({ id, name, image }) => {
    try {
      const formData = new FormData();
      formData.append("images", image);
      formData.append("name", name);
      const response = await brandApi.put(`/update/${id}`, formData);
      return { id, message: response.data.message, data: response.data.data };
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const deleteBrand = createAsyncThunk("/delete", async (id) => {
  try {
    const response = await brandApi.delete(`/delete/${id}`);
    return { id, message: response.data };
  } catch (error) {
    throw error.response.data;
  }
});

const brandSliceTest = createSlice({
  name: "brandTest",
  initialState,
  extraReducers: (builder) => {
    //get all the brands
    builder
      .addCase(getBrandsTest.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(getBrandsTest.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        state.brands = action.payload;
      })
      .addCase(getBrandsTest.rejected, (state, action) => {
        state.loading = "rejected";
        state.error = action.error || "An error occurred. Please try again.";
      });

    //create a brand
    builder
      .addCase(createBrand.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(createBrand.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        const { message, newBrand } = action.payload;
        state.message = message;
        state.brands.push(newBrand);
      })
      .addCase(createBrand.rejected, (state, action) => {
        state.loading = "rejected";
        state.error = action.error || "An error occurred. Please try again.";
      });

    //update a brand
    builder
      .addCase(updateBrand.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(updateBrand.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        state.message = action.payload.message;
        state.brands = state.brands.map((brand) => {
          if (brand.id === action.payload.id) {
            return action.payload.data;
          }
          return brand;
        });
      })
      .addCase(updateBrand.rejected, (state, action) => {
        state.loading = "rejected";
        console.log(action.error);
        state.error = action.error || "An error occurred. Please try again.";
      });

    //delete
    builder
      .addCase(deleteBrand.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(deleteBrand.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        const { id, message } = action.payload;
        state.message = message;
        state.brands = state.brands.filter((brand) => brand.id !== id);
      })
      .addCase(deleteBrand.rejected, (state, action) => {
        state.loading = "rejected";
        state.error = action.error || "An error occurred. Please try again.";
      });

    //get one brand
    builder.addCase(getOneBrand.fulfilled, (state, action) => {
      state.brand = action.payload;
    });
  },
});

export default brandSliceTest.reducer;
