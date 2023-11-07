import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import { categoryApi } from "../api";

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
    try {
      const response = await categoryApi.get("/");
      return response.data;
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const saveCategory = createAsyncThunk(
  "categories/saveCateogry",
  async ({ name }) => {
    try {
      const response = await categoryApi.post("/create", {name}, config);
      return response.data;
    } catch (error) {
      throw error.response.data;
    }
  }
);
export const deleteCategory = createAsyncThunk(
  "categories/deleteCategory",
  async (id) => {
    try {
      const response = await categoryApi.delete(`/delete/${id}`, config);
      return { id, message: response.data.message };
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const updateCategory = createAsyncThunk(
  "categories/updateCategory",
  async ({ id, name }) => {
    try {
      const response = await categoryApi.put(
        `/update/${id}`,
        {
          name,
        },
        config
      );
      console.log(response.data);
      return { id, message: response.data.message, data: response.data.data };
    } catch (error) {
      throw error.response.data;
    }
  }
);
const categoryEntity = createEntityAdapter({
  selectId: (category) => category.id,
});

const categorySlice = createSlice({
  name: "categories",
  initialState: categoryEntity.getInitialState(),
  extraReducers: (builder) => {
    builder
      .addCase(getCategories.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getCategories.fulfilled, (state, action) => {
        state.loading = false;
        state.error = null;
        categoryEntity.setAll(state, action.payload);
      })
      .addCase(getCategories.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error || "An error occurred. Please try again.";
      });
    builder.addCase(saveCategory.fulfilled, (state, action) => {
      categoryEntity.addOne(state, action.payload.newCategory);
    });
    builder.addCase(deleteCategory.fulfilled, (state, action) => {
      categoryEntity.removeOne(state, action.payload.id);
    });
    builder.addCase(updateCategory.fulfilled, (state, action) => {
      categoryEntity.updateOne(state, {
        id: action.payload.id,
        changes: action.payload.data,
      });
    });
  },

  // {
  //   [getCategories.fulfilled]: (state, action) => {
  //     state.status = "success";
  //     categoryEntity.setAll(state, action.payload);
  //   },
  //   [getCategories.pending]: (state) => {
  //     state.status = "loading";
  //   },
  //   [getCategories.rejected]: (state, action) => {
  //     state.status = "rejected";
  //     state.error = action.error.message;
  //   },
  //   [saveCategories.fulfilled]: (state, action) => {
  //     categoryEntity.addOne(state, action.payload);
  //   },
  //   [deleteCategories.fulfilled]: (state, action) => {
  //     categoryEntity.removeOne(state, action.payload);
  //   },
  //   [updateCategories.fulfilled]: (state, action) => {
  //     categoryEntity.updateOne(state, {
  //       id: action.payload.id,
  //       updates: action.payload,
  //     });
  //   },
  // },
});

export const { selectAll: selectAllCategory, selectById: selectCategoryById } =
  categoryEntity.getSelectors((state) => state.categories);
export default categorySlice.reducer;
