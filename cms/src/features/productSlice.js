import {createSlice,createAsyncThunk,createEntityAdapter} from "@reduxjs/toolkit"
import axios from 'axios'

export const getProducts = createAsyncThunk("products/getProducts",async()=>{
    const response = await axios.get('http://localhost:3000/products')
    return response.data
})
export const saveProducts = createAsyncThunk("products/saveProducts", async({name,price,description,stock,image,color,categoryId,brandId})=> {
    const response = await axios.post('http://localhost:3000/products/create',{
        name,price,description,stock,image,color,categoryId,brandId    
})
    return response.data
})
const productEntity = createEntityAdapter({
    selectId:(products)=> products.id
})

const productSlice = createSlice({
    name:"products",
    initialState : productEntity.getInitialState(),
    extraReducers : {
        
        [getProducts.pending] : (state) => {
           state.isLoading= true
           
        },
        [getProducts.fulfilled] : (state,action) => {
            state.isLoading= false
            productEntity.setAll(state,action.payload)
        },
        [getProducts.rejected] : (state,action) => {
            state.isLoading= false
            state.error = action.error.message
         },
        [saveProducts.fulfilled] : (state,action) => {
            productEntity.addOne(state,action.payload)
        }
    }
})

export const productSelectors = productEntity.getSelectors(state => state.products)
export default productSlice.reducer;