import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { userApi } from "../api";

const initialState = {
  currentUser: null,
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
});

const authSlice = createSlice({
  name: "auth",
  initialState,
  extraReducers: (builder) => {
    builder.addCase(login.fulfilled, (state, action) => {
      localStorage.setItem("Authorization", action.payload.accessToken);
      localStorage.setItem("currentUser", JSON.stringify(action.payload.currentUser));
      state.currentUser = action.payload.currentUser;
    });

    builder.addCase(logout.fulfilled, (state, action) => {
      state.currentUser = null;
      localStorage.clear();
    });
  },
});

export default authSlice.reducer;
