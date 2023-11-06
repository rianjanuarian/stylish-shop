import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import axios from "axios";
import { saveBrands } from "./brandSlice";

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
      }
    );
    return response.data;
  }
);
export const deleteCategories = createAsyncThunk(
  "categories/deleteCategories",
  async (id) => {
    await axios.delete(`http://localhost:3000/categories/delete/${id}`);
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
      }
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
      categoryEntity.setAll(state, action.payload);
    },
    [saveBrands.fulfilled]: (state, action) => {
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
