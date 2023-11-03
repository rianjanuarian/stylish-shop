import {createSlice,createAsyncThunk,createEntityAdapter} from "@reduxjs/toolkit"
import axios from 'axios'

export const getBrands = createAsyncThunk("brands/getBrands",async()=>{
    const response = await axios.get('http://localhost:3000/brands')
    return response.data
})

export const saveBrands = createAsyncThunk('brands/saveBrands',async({name,image})=>{
    const response = await axios.post('http://localhost:3000/brands/create',{
        name,image
    })
    return response.data
})

const brandEntity = createEntityAdapter({
    selectId: (brands) => brands.id
})

const brandSlice = createSlice({
    name: "brands",
    initialState: brandEntity.getInitialState(),
    extraReducers:{
        [getBrands.fulfilled] : (state,action) => {
            brandEntity.setAll(state,action.payload)
        },
        [saveBrands.fulfilled] : (state,action) => {
            brandEntity.addOne(state,action.payload)
        }
    }
})

export const brandSelectors = brandEntity.getSelectors(state => state.brands)
export default brandSlice.reducer