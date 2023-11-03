import React, { useState, useEffect } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import {
  updateBrands,
  brandSelectors,
  getBrands,
} from "../../features/brandSlice";
import { useParams, useNavigate } from "react-router-dom";

import { useDispatch, useSelector } from "react-redux";
const EditBrand = () => {
  const [name, setName] = useState("");
  const [image, setImage] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { id } = useParams();
  const brand = useSelector((state) => brandSelectors.selectById(state, id));
  useEffect(() => {
    dispatch(getBrands());
  }, [dispatch]);

  useEffect(() => {
    if (brand) {
      setName(brand.name);
      setImage(brand.image);
    }
  }, [brand]);
  const handleUpdate = async (e) => {
    e.preventDefault();

    await dispatch(updateBrands({ id, name, image }));
    navigate("/brands");
  };
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Brand</h1>
          <form onSubmit={handleUpdate}>
            <label for="fname">Name</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
            />

            <label for="fname">Image</label>
            <input type="file" onChange={handleImageChange} />

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default EditBrand;
