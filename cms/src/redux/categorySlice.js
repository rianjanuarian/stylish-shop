import {createSlice,createAsyncThunk,createEntityAdapter} from "@reduxjs/toolkit"
import axios from 'axios'
import { saveBrands } from "./brandSlice"

export const getCategories = createAsyncThunk("categories/getCategories",async()=>{
    const response = await axios.get('http://localhost:3000/categories')
    return response.data
})

export const saveCategories = createAsyncThunk("categories/saveCateogires",async({name})=> {
    const response = await axios.post("http://localhost:3000/categories/create",{
        name
    })
    return response.data
})

const categoryEntity = createEntityAdapter({
    selectId : (categories) => categories.id
})

const categorySlice = createSlice({
    name: "categories",
    initialState: categoryEntity.getInitialState(),
    extraReducers:{
        [getCategories.fulfilled] : (state,action) =>{
            categoryEntity.setAll(state,action.payload)
        },
        [saveBrands.fulfilled] : (state,action) => {
            categoryEntity.addOne(state,action.payload)
        }
    }
})

export const categorySelectors = categoryEntity.getSelectors(state => state.categories)
export default categorySlice.reducer