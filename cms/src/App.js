
// import './App.css';
// import { Login } from './components';
// function App() {
//   return (
//    <>
//    <Login></Login>
//    </>
//   );
// }

// export default App;
import React from 'react';
import {  Routes, Route  } from 'react-router-dom';

// import SideBar from './components/Sidebar';
// import sidebar_menu from './constants/sidebar-menu';

import './App.css';
// import Orders from './pages/Orders/Order';
import { LoginPage,Orders } from './pages';
import {MainContent} from './components'
function App () {
  return(
    <>
    

   
      
      <MainContent></MainContent>

    </>
   
  )
}

export default App;