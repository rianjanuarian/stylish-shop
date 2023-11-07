import {
  createSlice,
  createAsyncThunk,
  createEntityAdapter,
} from "@reduxjs/toolkit";
import { courierApi } from "../api";

const accessToken = localStorage.getItem("Authorization");
const config = {
  headers: {
    "Content-Type": "multipart/form-data",
    Authorization: `Bearer ${accessToken}`,
  },
  withCredentials: true,
};

export const getCouriers = createAsyncThunk("/get_couriers", async () => {
  try {
    const response = await courierApi.get("/");
    return response.data;
  } catch (error) {
    throw error.response.data;
  }
});

export const createCourier = createAsyncThunk(
  "couriers/create",
  async ({ name, price, image }) => {
    try {
      const formData = new FormData();
      formData.append("name", name);
      formData.append("price", price);
      formData.append("images", image);
      const response = await courierApi.post("/create", formData, config);
      return response.data;
    } catch (error) {
      throw error.response.data;
    }
  }
);

export const updateCourier = createAsyncThunk(
  "couriers/update",
  async ({ id, name, price, image }) => {
    const formData = new FormData();
    formData.append("name", name);
    formData.append("price", price);
    formData.append("images", image);
    const response = await courierApi.put(`/update/${id}`, formData, config);
    return { id, message: response.data.message, data: response.data.data };
  }
  );
  
  export const deleteCourier = createAsyncThunk("/delete_courier", async (id) => {
    try {
      const response = await courierApi.delete(`/delete/${id}`, config);
      return { id, message: response.data.message };
    } catch (error) {
      throw error.response.data;
    }
  });

  const courierEntity = createEntityAdapter({
    selectId: (courier) => courier.id,
  });

const courierSlice = createSlice({
  name: "couriers",
  initialState: courierEntity.getInitialState(),
  extraReducers: (builder) => {
    //get
    builder
      .addCase(getCouriers.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getCouriers.fulfilled, (state, action) => {
        state.loading = false;
        state.error = null;
        courierEntity.setAll(state, action.payload);
      })
      .addCase(getCouriers.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error || "An error occurred. Please try again.";
        console.log(action.error);
      });
    //add
    builder.addCase(createCourier.fulfilled, (state, action) => {
      courierEntity.addOne(state, action.payload.newCourier);
    });
    //delete
    builder.addCase(deleteCourier.fulfilled, (state, action) => {
      courierEntity.removeOne(state, action.payload.id);
    });
    //update
    builder.addCase(updateCourier.fulfilled, (state, action) => {
      courierEntity.updateOne(state, {
        id: action.payload.id,
        changes: action.payload.data,
      });
    });
  },
});

export const { selectAll: selectAllCouriers, selectById: selectCourierById } =
  courierEntity.getSelectors((state) => state.couriers);
export default courierSlice.reducer;
