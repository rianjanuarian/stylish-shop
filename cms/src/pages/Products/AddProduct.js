import React, { useState,useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { saveProducts } from "../../features/productSlice";
import { useNavigate } from "react-router-dom";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { categorySelectors, getCategories } from "../../features/categorySlice";
import { brandSelectors, getBrands } from "../../features/brandSlice";
const AddProduct = () => {
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");
  const [stock, setStock] = useState("");
  const [image, setImage] = useState("");
  const [color, setColor] = useState("");
  const [categoryId, setCategoryId] = useState('');
  const [brandId, setBrand] = useState('');

  const categories = useSelector(categorySelectors.selectAll)
  const brands = useSelector(brandSelectors.selectAll)

  const createProduct = async (e) => {
    
    await dispatch(
      saveProducts({
        name: name,
        price: price,
        description: description,
        stock: stock,
        image: image,
        color: color,
        categoryId: categoryId,
        brandId: brandId,
      })
    );
    window.location.href = "/products";
  };
  const dispatch = useDispatch();
  const navigate = useNavigate();

  useEffect(() => {
    dispatch(getCategories())
    dispatch(getBrands())
  }, [dispatch]);
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Product</h1>
          <form onSubmit={createProduct}>
            <label for="fname">Name</label>
            <input type="text" onChange={(e) => setName(e.target.value)} name="firstname" />

            <label for="fname">Price</label>
            <input type="number" onChange={(e) => setPrice(e.target.value)} name="lastname" />

            <label for="fname">Description</label>
            <input type="text" onChange={(e) => setDescription(e.target.value)} name="firstname" />

            <label for="fname">Stock</label>
            <input type="number" onChange={(e) => setStock(e.target.value)} name="firstname" />

            <label for="fname">Image</label>
            <input type="file" onChange={(e) => setImage(e.target.value)} name="firstname" />

            <label for="fname">Color</label>
            <input type="text" onChange={(e) => setColor(e.target.value)} name="firstname" />

         
             <label for="fname">Category</label>
            <select id="category"  name="category"  onChange={(el)=>setCategoryId(el.target.value)}>
            <option value="" disabled selected>--</option>
          {categories.map((e)=> (
            <option key={e.id} value={e.id}>{e.name}</option>
            
          ))}
              
            </select>
            <label for="fname">Brand</label>
            <select id="brand" name="brand" onChange={(el)=>setBrand(el.target.value)}>
            <option value="" disabled selected>--</option>
            {brands.map((e)=> (
            <option key={e.id} value={e.id}>{e.name}</option>
            
          ))}
            </select> 

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default AddProduct;
