import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import { brandApi } from "../api";

const accessToken = localStorage.getItem("Authorization");
const config = {
  headers: {
    "Content-Type": "multipart/form-data",
    Authorization: `Bearer ${accessToken}`,
  },
  withCredentials: true,
};

export const getBrands = createAsyncThunk("brands/getBrands", async () => {
  try {
    const response = await brandApi("/");
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const saveBrand = createAsyncThunk(
  "brands/saveBrands",
  async ({ name, image }) => {
    try {
      // await new Promise(resolve => setTimeout(resolve, 5000));
      const formData = new FormData();
      formData.append("name", name);
      formData.append("images", image);
      const response = await brandApi.post("/create", formData, config);
      return response.data;
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const updateBrand = createAsyncThunk(
  "brands/updateBrands",
  async ({ id, name, image }) => {
    try {
      const formData = new FormData();
      formData.append("images", image);
      formData.append("name", name);
      const response = await brandApi.put(`/update/${id}`, formData, config);
      return { id, message: response.data.message, data: response.data.data };
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const deleteBrand = createAsyncThunk(
  "products/deleteBrands",
  async (id) => {
    try {
      const response = await brandApi.delete(`/delete/${id}`);
      return { id, message: response.data.message };
    } catch (error) {
      throw error.response.data;
    }
  }
);

const brandEntity = createEntityAdapter({
  selectId: (brand) => brand.id,
});

const brandSlice = createSlice({
  name: "brands",
  initialState: brandEntity.getInitialState(),
  extraReducers: (builder) => {
    //get
    builder
      .addCase(getBrands.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getBrands.fulfilled, (state, action) => {
        state.loading = false;
        state.error = null;
        brandEntity.setAll(state, action.payload);
      })
      .addCase(getBrands.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error || "An error occurred. Please try again.";
      });
    //add
    builder.addCase(saveBrand.fulfilled, (state, action) => {
      console.log(action.payload);
      brandEntity.addOne(state, action.payload.newBrand);
    });
    //delete
    builder.addCase(deleteBrand.fulfilled, (state, action) => {
      brandEntity.removeOne(state, action.payload.id);
    });
    //update
    builder.addCase(updateBrand.fulfilled, (state, action) => {
      brandEntity.updateOne(state, {
        id: action.payload.id,
        changes: action.payload.data,
      });
    });
  },
});

export const { selectAll: selectAllBrands, selectById: selectBrandById } =
  brandEntity.getSelectors((state) => state.brands);
export default brandSlice.reducer;
