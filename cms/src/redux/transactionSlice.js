import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import axios from "axios";

export const getTransactions = createAsyncThunk(
  "transactions/getTransactions",
  async () => {
    const response = await axios.get("http://localhost:3000/transactions");
    return response.data;
  }
);

const transactionEntity = createEntityAdapter({
  selectId: (transactions) => transactions.id,
});

const transactionSlice = createSlice({
  name: "transactions",
  initialState: transactionEntity.getInitialState(),
  extraReducers: {
    [getTransactions.fulfilled]: (state, action) => {
      state.status = "success";
      transactionEntity.setAll(state, action.payload);
    },
    [getTransactions.rejected]: (state, action) => {
      state.status = "rejected";
      state.error = action.error.message
    },
    [getTransactions.pending] : (state) => {
      state.status = "loading"
    }
  },
});

export const transactionSelectors = transactionEntity.getSelectors(
  (state) => state.transactions
);
export default transactionSlice.reducer;
