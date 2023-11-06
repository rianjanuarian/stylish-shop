import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import axios from "axios";

const accessToken = localStorage.getItem("Authorization")  || "";
const config = {
  headers: {
    "Content-Type": "application/json",
    Authorization: `Bearer ${accessToken}`,
  },
  withCredentials: true,
};

export const getBrands = createAsyncThunk("brands/getBrands", async () => {
  const response = await axios.get("http://localhost:3000/brands", config);
  return response.data;
});

export const saveBrands = createAsyncThunk(
  "brands/saveBrands",
  async (formData) => {

    const response = await axios.post(
      "http://localhost:3000/brands/create",
      formData
    );

    return response.data;
  }
);
export const deleteBrands = createAsyncThunk(
  "products/deleteBrands",
  async (id) => {
    await axios.delete(`http://localhost:3000/brands/delete/${id}`);
    return id;
  }
);

export const updateBrands = createAsyncThunk(
  "brands/updateBrands",
  async ({ id, name, image }) => {
    const formData = new FormData();
    formData.append("images", image);
    formData.append("name", name);
    const response = await axios.put(
      `http://localhost:3000/brands/update/${id}`,
      formData
    );
    return response.data;
  }
);
const brandEntity = createEntityAdapter({
  selectId: (brands) => brands.id,
});

const brandSlice = createSlice({
  name: "brands",
  initialState: brandEntity.getInitialState(),
  extraReducers: {
    [getBrands.pending]: (state) => {
      state.status = "loading";
    },
    [getBrands.rejected]: (state, action) => {
      state.status = "rejected";
      state.error = action.error.message;
    },
    [getBrands.fulfilled]: (state, action) => {
      state.status = "success"
      brandEntity.setAll(state, action.payload);
    },
 
    [saveBrands.fulfilled]: (state, action) => {
      brandEntity.addOne(state, action.payload);
    },
    [deleteBrands.fulfilled]: (state, action) => {
      brandEntity.removeOne(state, action.payload);
    },
    [updateBrands.fulfilled]: (state, action) => {
      brandEntity.updateOne(state, {
        id: action.payload.id,
        updates: action.payload,
      });
    },
  },
});

export const brandSelectors = brandEntity.getSelectors((state) => state.brands);
export default brandSlice.reducer;
