import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { userApi } from "../api";

const initialState = {
  loading: false,
  error: null,
  accessToken: localStorage.getItem("Authorization") || null,
};

export const login = createAsyncThunk("/login", async (formData) => {
  try {
    const response = await userApi.post("/login_admin", formData);
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const logout = createAsyncThunk("/logout", async () => {
  try {
    const response = await userApi.get("/logout");
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
})

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
        localStorage.setItem("Authorization", action.payload.access_token);
        state.accessToken = action.payload.access_token;
      })
      .addCase(login.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error || "An error occurred. Please try again.";
        console.log(action.error);
      });
    builder
      .addCase(logout.fulfilled, (state, action) => {
        state.loading = false;
        state.error = null;
        state.accessToken = null;
        localStorage.clear();
      })
  },
});

export default authSlice.reducer;
