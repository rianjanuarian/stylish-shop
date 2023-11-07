import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import axios from "axios";

const accessToken = localStorage.getItem("Authorization");
const config = {
  headers: {
    "Content-Type": "application/json",
    Authorization: `Bearer ${accessToken}`,
  },

  withCredentials: true,
};

export const getCategories = createAsyncThunk(
  "categories/getCategories",
  async () => {
    const response = await axios.get("http://localhost:3000/categories");
    return response.data;
  }
);

export const saveCategories = createAsyncThunk(
  "categories/saveCateogires",
  async ({ name }) => {
    const response = await axios.post(
      "http://localhost:3000/categories/create",
      {
        name,
      },
      config
    );
    return response.data;
  }
);
export const deleteCategories = createAsyncThunk(
  "categories/deleteCategories",
  async (id) => {
    await axios.delete(`http://localhost:3000/categories/delete/${id}`,config);
    return id;
  }
);

export const updateCategories = createAsyncThunk(
  "categories/updateCategories",
  async ({ id, name }) => {
    const response = await axios.put(
      `http://localhost:3000/categories/update/${id}`,
      {
        name,
      },
      config
    );
    return response.data;
  }
);
const categoryEntity = createEntityAdapter({
  selectId: (categories) => categories.id,
});

const categorySlice = createSlice({
  name: "categories",
  initialState: categoryEntity.getInitialState(),
  extraReducers: {
    [getCategories.fulfilled]: (state, action) => {
      state.status = "success"
      categoryEntity.setAll(state, action.payload);
    },
    [getCategories.pending] : (state) => {
      state.status = "loading"
    },
    [getCategories.rejected] : (state,action)=>{
      state.status = "rejected"
      state.error = action.error.message
    },
    [saveCategories.fulfilled]: (state, action) => {
      categoryEntity.addOne(state, action.payload);
    },
    [deleteCategories.fulfilled]: (state, action) => {
      categoryEntity.removeOne(state, action.payload);
    },
    [updateCategories.fulfilled]: (state, action) => {
      categoryEntity.updateOne(state, {
        id: action.payload.id,
        updates: action.payload,
      });
    },
  },
});

export const categorySelectors = categoryEntity.getSelectors(
  (state) => state.categories
);
export default categorySlice.reducer;
