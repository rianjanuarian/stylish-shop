import React, { useState, useEffect } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import {
  updateCategories,
  categorySelectors,
  getCategories,
} from "../../features/categorySlice";
import { useParams, useNavigate } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
const EditCategory = () => {
  const [name, setName] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const { id } = useParams();
  const category = useSelector((state) =>
    categorySelectors.selectById(state, id)
  );
  useEffect(() => {
    dispatch(getCategories);
  }, [dispatch]);

  useEffect(() => {
    if (category) {
      setName(category.name);
    }
  }, [category]);

  const handleUpdate = async(e)=>{
    e.preventDefault()
    await dispatch(updateCategories({id,name}))
    navigate("/categories")

  }
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Edit Category</h1>
          <form onSubmit={handleUpdate}>
            <label for="fname">Name</label>
            <input type="text" value={name} onChange={(e)=> setName(e.target.value)} name="firstname" />

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default EditCategory;
