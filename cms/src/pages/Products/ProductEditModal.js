import React, { useEffect, useState } from "react";
import { getCategories, selectAllCategories } from "../../redux/categorySlice";
import { getBrands, selectAllBrands } from "../../redux/brandSlice";
import { useDispatch, useSelector } from "react-redux";
import Swal from "sweetalert2";
import { selectProductById, updateProduct } from "../../redux/productSlice";

const ProductEditModal = (props) => {
  const id = props.productId;
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");
  const [stock, setStock] = useState("");
  const [image, setImage] = useState("");
  const [colors, setColors] = useState([]);
  const [categoryId, setCategoryId] = useState(null);
  const [brandId, setBrandId] = useState(null);
  const [isLoading, setIsLoading] = useState(false);

  const categories = useSelector(selectAllCategories);
  const brands = useSelector(selectAllBrands);
  const product = useSelector((state) => selectProductById(state, id));
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(getCategories());
    dispatch(getBrands());
  }, [dispatch]);

  useEffect(() => {
    if (product) {
      setName(product.name);
      setPrice(product.price);
      setDescription(product.description);
      setStock(product.stock);
      setImage(product.image);
      setColors(product.colors);
      setCategoryId(product.categories[0].id);
      setBrandId(product.brands[0].id);
    }
  }, [product]);

  const handleColorChange = (color) => {
    if (colors.includes(color)) {
      setColors(colors.filter((c) => c !== color));
    } else {
      setColors((prevColors) => [...prevColors, color]);
    }
  };

  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(
      updateProduct({
        id,
        name,
        price,
        description,
        stock,
        image,
        colors,
        categoryId,
        brandId,
      })
    )
      .unwrap()
      .then((data) => {
        setIsLoading(false);
        props.toggleModalEdit();
        Swal.fire({
          icon: "success",
          title: data.message,
          showConfirmButton: false,
          timer: 1500,
        });
      })
      .catch((err) => {
        setIsLoading(false);
        Swal.fire({
          icon: "error",
          title: "Error",
          text: err.message,
          footer: err.stack,
        });
      });
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModalEdit}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Edit Product</h1>
          <form onSubmit={handleUpdate} encType="multipart/form-data">
            <label>Name</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
            />

            <label>Price</label>
            <input
              type="number"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
            />

            <label>Description</label>
            <input
              type="text"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
            />

            <label>Stock</label>
            <input
              type="number"
              value={stock}
              onChange={(e) => setStock(e.target.value)}
            />

            <label>Image</label>
            <input type="file" onChange={handleImageChange} />

            <div className="colors">
              <label htmlFor="color">Select Colors:</label>
              <div className="color-option">
                <div>
                  <input
                    type="checkbox"
                    name="colors"
                    value="red"
                    checked={colors.includes("Red")}
                    onChange={() => handleColorChange("Red")}
                  />
                  <label> Red</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    name="colors"
                    value="green"
                    checked={colors.includes("Green")}
                    onChange={() => handleColorChange("Green")}
                  />
                  <label> Green</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    name="colors"
                    value="blue"
                    checked={colors.includes("Blue")}
                    onChange={() => handleColorChange("Blue")}
                  />
                  <label> Blue</label>
                </div>
                <div>
                  <input
                    type="checkbox"
                    name="colors"
                    value="yellow"
                    checked={colors.includes("Yellow")}
                    onChange={() => handleColorChange("Yellow")}
                  />
                  <label> Yellow</label>
                </div>
              </div>
            </div>

            <label htmlFor="fname">Category</label>
            <select
              id="category"
              name="category"
              onChange={(e) => setCategoryId(e.target.value)}
            >
              <option value="" disabled defaultValue>
                --
              </option>
              {categories.map((category) => (
                <option key={category.id} value={category.id} selected={category.id === categoryId}>
                  {category.name}
                </option>
              ))}
            </select>
            <label htmlFor="fname">Brand</label>
            <select
              id="brand"
              name="brand"
              onChange={(e) => setBrandId(e.target.value)}
            >
              <option value="" disabled defaultValue>
                --
              </option>
              {brands.map((brand) => (
                <option key={brand.id} value={brand.id} selected={brand.id === brandId}>
                  {brand.name}
                </option>
              ))}
            </select>

            <input type="submit" value="Submit" disabled={isLoading} />
          </form>
        </div>
      </div>
    </div>
  );
};

export default ProductEditModal;
