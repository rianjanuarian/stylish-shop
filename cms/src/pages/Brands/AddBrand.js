import React, { useState } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { saveBrands } from "../../redux/brandSlice";
import { useDispatch } from "react-redux";

import { useNavigate } from "react-router-dom";
const AddBrand = () => {

const [name, setName] = useState('')
const [image, setImage] = useState(null)
const handleImageChange = (event) => {
  setImage(event.target.files[0]);
};
  const dispatch = useDispatch()
  const navigate = useNavigate()
  const createBrand = async (e) => {
    e.preventDefault()
    const formData = new FormData();
    formData.append("images", image);
    formData.append('name',name)
   
    await dispatch(saveBrands(formData))
    navigate('/brands')
  }

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Brand</h1>
          <form onSubmit={createBrand}>
            <label htmlFor="fname">Name</label>
            <input type="text" onChange={(e) => setName(e.target.value)} />

            <label htmlFor="fname">Image</label>

            <input type="file"  onChange={handleImageChange}  />



            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default AddBrand;
