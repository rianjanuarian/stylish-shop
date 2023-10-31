import React from 'react'
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
const AddBrand = () => {
  return (
    <div className="dashboard-container">
    <SideBar menu={sidebar_menu} />
    <div className="dashboard-body">
        <h1>Add Brand</h1>
        </div>

        </div>
  )
}

export default AddBrand