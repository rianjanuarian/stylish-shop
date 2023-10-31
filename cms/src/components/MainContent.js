import React from 'react'
import {  Routes, Route  } from 'react-router-dom';
import { LoginPage,Dashboard,Orders } from '../pages';
import sidebar_menu from '../constants/sidebar-menu';
import SideBar from './Sidebar/Sidebar';
const MainContent = () => {
  return (
    <>
    
    <Routes>
              <Route path="/" element={<LoginPage></LoginPage>} />
              </Routes>
              <div className='dashboard-container'>
              <SideBar menu={sidebar_menu} />
              <div className='dashboard-body'>
              <Routes>
                  <Route exact path="/dashboard"element={<Dashboard></Dashboard>} />
                  <Route exact path="/orders" element={< Orders/>} />
                  <Route exact path="/locations" element={<div></div>} />
                  <Route exact path="/profile" element={<div></div>} />
                  
              </Routes>
              </div>
              </div>
    </>

  )
}

export default MainContent