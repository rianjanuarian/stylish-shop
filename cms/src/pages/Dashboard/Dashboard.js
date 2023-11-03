import React from 'react'
import sidebar_menu from '../../constants/sidebar-menu';
import SideBar from '../../components/Sidebar/Sidebar';
const Dashboard = () => {
  return (
    <div className='dashboard-container'>
    <SideBar menu={sidebar_menu} />
    <div className='dashboard-body'>
      <h1>Dashboard</h1>
      </div>
      </div>
  )
}

export default Dashboard