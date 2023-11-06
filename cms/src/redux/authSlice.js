import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { userApi } from "../api";

const initialState = {
  loading: false,
  error: null,
  accessToken: localStorage.getItem("access_token") || null,
};

export const login = createAsyncThunk("/login", async (formData) => {
  try {
    const response = await userApi.post("/login_with_email", formData);
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const logout = () => {
  localStorage.clear();
};

const authSlice = createSlice({
  name: "auth",
  initialState,
  extraReducers: (builder) => {
    builder
      .addCase(login.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(login.fulfilled, (state, action) => {
        state.loading = false;
        state.error = null;
        localStorage.setItem("access_token", action.payload.access_token);
        state.accessToken = action.payload.access_token;
      })
      .addCase(login.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error || "An error occurred. Please try again.";
        console.log(action.error);
      });
  },
});

export default authSlice.reducer;
