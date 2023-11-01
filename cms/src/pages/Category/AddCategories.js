import React, { useState } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { saveCategories } from "../../features/categorySlice";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
const AddCategories = () => {
  const [name, setName] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const createCategory = async (e) => {
    e.preventDefault();
    await dispatch(saveCategories({ name: name }));
    navigate("/categories");
  };
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Category</h1>
          <form onSubmit={createCategory}>
            <label for="fname">Name</label>
            <input
              type="text"
              onChange={(e) => setName(e.target.value)}
              name="firstname"
            />

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default AddCategories;
