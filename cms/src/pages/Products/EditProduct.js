import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { updateProducts,productSelectors,getProducts } from "../../redux/productSlice";
import { categorySelectors, getCategories } from "../../redux/categorySlice";
import { brandSelectors, getBrands } from "../../redux/brandSlice";
import { useParams, useNavigate } from "react-router-dom";
const EditProduct = () => {
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");
  const [stock, setStock] = useState("");
  const [image, setImage] = useState("");
  const [color, setColor] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [brandId, setBrand] = useState("");

  const categories = useSelector(categorySelectors.selectAll);
  const brands = useSelector(brandSelectors.selectAll);
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { id } = useParams();

  const product = useSelector((state)=>productSelectors.selectById(state,id))
  useEffect(() => {
    dispatch(getProducts())

  }, [dispatch])

  useEffect(() => {
    if(product){
      setName(product.name)
      setPrice(product.price)
      setDescription(product.description)
      setStock(product.stock)
      setImage(product.image)
      setColor(product.color)
      setCategoryId(product.categoryId)
      setBrand(product.brandId)
    }
  
    
  }, [product])
  const handleUpdate = async(e) => {
    e.preventDefault()
    await dispatch(updateProducts({id,name,price,description,stock,image,color,categoryId,brandId}))
    navigate('/products')
  }
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Edit Product</h1>
          <form onSubmit={handleUpdate}>
            <label>Name</label>
            <input type="text" value={name} onChange={(e) => setName(e.target.value)} />

            <label>Price</label>
            <input type="number" value={price} onChange={(e) => setPrice(e.target.value)} />

            <label>Description</label>
            <input
              type="text"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />

            <label>Stock</label>
            <input type="number" value={stock} onChange={(e) => setStock(e.target.value)} />

            <label>Image</label>
            <input type="file" onChange={handleImageChange}/>

            <label for="color">Color</label>
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

            <label for="fname">Category</label>
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
            <label for="fname">Brand</label>
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
  )
}

export default EditProduct