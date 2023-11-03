import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";

import React from 'react'

const AddUser = () => {
  return (
    <div className="dashboard-container">
    <SideBar menu={sidebar_menu} />
    <div className="dashboard-body">
        <h1>Add User</h1>
        </div>

        </div>
  )
}

export default AddUser