import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { categoryApi } from "../api";

const initialState = {
  categories: [],
  category: null,
  loading: "idle",
  message: null,
  error: null,
};

export const getCategoriesTest = createAsyncThunk("/category", async () => {
  try {
    const response = await categoryApi.get("/");
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const createCategory = createAsyncThunk("/create", async (formData) => {
  try {
    const response = await categoryApi.post("/create", formData);
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const getOneCategory = createAsyncThunk(
  "/getOneCategory",
  async (id) => {
    const response = await categoryApi.get(`/details/${id}`);
    return response.data;
  }
);

export const updateCategory = createAsyncThunk(
  "/update",
  async ({ id, name }) => {
    try {
      const response = await categoryApi.put(`/update/${id}`, { name });
      console.log({
        id,
        message: response.data.message,
        data: response.data.data,
      });
      return { id, message: response.data.message, data: response.data.data };
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const deleteCategory = createAsyncThunk("/delete", async (id) => {
  try {
    const response = await categoryApi.delete(`/delete/${id}`);
    return { id, message: response.data };
  } catch (error) {
    throw error.response.data;
  }
});

const categorySliceTest = createSlice({
  name: "categoryTest",
  initialState,
  extraReducers: (builder) => {
    //get all the categories
    builder
      .addCase(getCategoriesTest.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(getCategoriesTest.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        state.categories = action.payload;
      })
      .addCase(getCategoriesTest.rejected, (state, action) => {
        state.loading = "rejected";
        state.error = action.error || "An error occurred. Please try again.";
      });

    //create a category
    builder
      .addCase(createCategory.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(createCategory.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        console.log(action.payload);
        const { message, categories } = action.payload;
        state.message = message;
        state.categories.push(categories);
      })
      .addCase(createCategory.rejected, (state, action) => {
        state.loading = "rejected";
        state.error = action.error || "An error occurred. Please try again.";
      });

    //update a category
    builder
      .addCase(updateCategory.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(updateCategory.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        state.message = action.payload.message;
        state.categories = state.categories.map((category) => {
          if (category.id === action.payload.id) {
            return action.payload.data;
          }
          return category;
        });
      })
      .addCase(updateCategory.rejected, (state, action) => {
        state.loading = "rejected";
        console.log(action.error);
        state.error = action.error || "An error occurred. Please try again.";
      });

    //delete
    builder
      .addCase(deleteCategory.pending, (state) => {
        state.loading = "pending";
        state.error = null;
      })
      .addCase(deleteCategory.fulfilled, (state, action) => {
        state.loading = "fulfilled";
        state.error = null;
        const { id, message } = action.payload;
        state.message = message;
        state.categories = state.categories.filter(
          (category) => category.id !== id
        );
      })
      .addCase(deleteCategory.rejected, (state, action) => {
        state.loading = "rejected";
        state.error = action.error || "An error occurred. Please try again.";
      });

    //get one category
    builder.addCase(getOneCategory.fulfilled, (state, action) => {
      state.category = action.payload;
    });
  },
});

export default categorySliceTest.reducer;
