import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import { userApi } from "../api";

const initialState = {
    loading: false,
    error: null,
    data: null,
};

const accessToken = localStorage.getItem("access_token");
const config = {
    headers: {
        "Content-Type": "application/json",
        access_token: `${accessToken}`,
    },
    withCredentials: true,
};

export const getUser = createAsyncThunk("/get_user_admin", async () => {
    try {
        const response = await userApi.get("/get_user_admin", config);
        return response.data;
    } catch (error) {
        throw error.response.data;
    }
});

const userSlice = createSlice({
    name: "auth",
    initialState,
    extraReducers: (builder) => {
        builder
            .addCase(getUser.pending, (state) => {
                state.loading = true;
                state.error = null;
            })
            .addCase(getUser.fulfilled, (state, action) => {
                state.loading = false;
                state.error = null;
                state.data = action.payload;
            })
            .addCase(getUser.rejected, (state, action) => {
                state.loading = false;
                state.error = action.error || "An error occurred. Please try again.";
                console.log(action.error);
            });
    },
});

export default userSlice.reducer;