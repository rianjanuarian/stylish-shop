import React,{useState} from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { saveBrands } from "../../features/brandSlice";
import { useDispatch } from "react-redux";

import { useNavigate } from "react-router-dom";
const AddBrand = () => {
const [name, setName] = useState('')
const [image, setImage] = useState('')
  const dispatch = useDispatch()
  const navigate = useNavigate()
  const createBrand = async (e) => {
    e.preventDefault()
    await dispatch(saveBrands({name:name, image:image }))
    navigate('/brands')
  }
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Brand</h1>
          <form onSubmit={createBrand}>
            <label for="fname">Name</label>
            <input type="text" onChange={(e) =>setName(e.target.value)} />

            <label for="fname">Image</label>
            <input type="file" onChange={(e)=> setImage(e.target.value)}  />

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default AddBrand;
