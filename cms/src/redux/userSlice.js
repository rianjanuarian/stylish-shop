import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import axios from "axios";

export const getUsers = createAsyncThunk("users/getUsers", async () => {
  const response = await axios.get("http://localhost:3000/users");
  return response.data;
});

const userEntity = createEntityAdapter({
  selectId: (users) => users.id,
});

const userSlice = createSlice({
  name: "user",
  initialState: userEntity.getInitialState(),
  extraReducers: {
    [getUsers.fulfilled]: (state, action) => {
      state.status = "success";
      userEntity.setAll(state, action.payload);
    },
    [getUsers.pending]: (state) => {
      state.status = "loading";
    },
    [getUsers.rejected]: (state, action) => {
      state.status = "rejected";
      state.error = action.error.message;
    },
  },
});
export const userSelectors = userEntity.getSelectors((state) => state.users)
export default userSlice.reducer