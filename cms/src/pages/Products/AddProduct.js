import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";

import { saveProducts } from "../../redux/productSlice";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { categorySelectors, getCategories, selectAllCategory } from "../../redux/categorySlice";
import { brandSelectors, getBrands, selectAllBrands } from "../../redux/brandSlice";
// import { useNavigate } from "react-router-dom";


const AddProduct = () => {
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");
  const [stock, setStock] = useState("");
  const [image, setImage] = useState('');
  const [color, setColor] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [brandId, setBrand] = useState("");




  const categories = useSelector(selectAllCategory);
  const brands = useSelector(selectAllBrands);
  // const navigate = useNavigate();
  const createProduct = async (e) => {

    e.preventDefault();

    await dispatch(
      saveProducts({
        name,
        price,
        description,
        stock,
        image,
        color,
        categoryId,
        brandId,
      })
    );

    window.location.href = "/products";
    // navigate("/products");
  };
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(getCategories());
    dispatch(getBrands());
  }, [dispatch]);
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Product</h1>

          <form onSubmit={createProduct} enctype="multipart/form-data">
            <label>Name</label>
            <input type="text" onChange={(e) => setName(e.target.value)} />

            <label>Price</label>
            <input type="number" onChange={(e) => setPrice(e.target.value)} />

            <label>Description</label>
            <input
              type="text"
              onChange={(e) => setDescription(e.target.value)}
            />

            <label>Stock</label>
            <input type="number" onChange={(e) => setStock(e.target.value)} />

            <label>Image</label>
            <input type="file" onChange={handleImageChange} />

            <label htmlFor="color">Color</label>
            <select
              id="color"
              name="color"
              onChange={(e) => setColor(e.target.value)}
            >
              <option value="" disabled selected>
                --
              </option>
              <option value="red">Red</option>
              <option value="white">White</option>
              <option value="black">Black</option>
              <option value="yellow">Yellow</option>
              <option value="green">Green</option>
            </select>

            <label htmlFor="fname">Category</label>
            <select
              id="category"
              name="category"
              onChange={(el) => setCategoryId(el.target.value)}
            >
              <option value="" disabled selected>
                --
              </option>
              {categories.map((e) => (
                <option key={e.id} value={e.id}>
                  {e.name}
                </option>
              ))}
            </select>
            <label htmlFor="fname">Brand</label>
            <select
              id="brand"
              name="brand"
              onChange={(el) => setBrand(el.target.value)}
            >
              <option value="" disabled selected>
                --
              </option>
              {brands.map((e) => (
                <option key={e.id} value={e.id}>
                  {e.name}
                </option>
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
