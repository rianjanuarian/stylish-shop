import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import SideBarItem from "./sidebar-item";
import "./sidebar.css";
import logo from "../../assets/images/logo2.png";
import LogoutIcon from "../../assets/icons/logout.svg";
import { useDispatch } from "react-redux";
import { logout } from "../../redux/authSlice";
import Swal from "sweetalert2";

function SideBar({ menu }) {
  const location = useLocation();
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const [active, setActive] = useState(1);


  useEffect(() => {
    menu.forEach((element) => {
      if (location.pathname === element.path) {
        setActive(element.id);
      }
    });
  }, [location.pathname, menu]);

  const __navigate = (id) => {
    setActive(id);
  };

  const handleLogout = () => {
    Swal.fire({
      title: "Are you sure you want to logged out?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, logout!",
    }).then((result) => {
      if (result.isConfirmed) {
        dispatch(logout()).then(() => {
          navigate('/');
        });
      }
    });

  }

  return (
    <nav className="sidebar">
      <div className="sidebar-container">
        <div className="sidebar-logo-container">
          <img src={logo} alt="logo" />
        </div>

        <div className="sidebar-container">
          <div className="sidebar-items">
            {menu.map((item, index) => (
              <div key={index} onClick={() => __navigate(item.id)}>
                <SideBarItem active={item.id === active} item={item} />
              </div>
            ))}
          </div>

          {/* <div className="sidebar-footer" onClick={handleLogout}>
            <span className="sidebar-item-label">Logout</span>
            <img
              src={LogoutIcon}
              alt="icon-logout"
              className="sidebar-item-icon"
            />
          </div> */}
        </div>
      </div>
    </nav>
  );
}

export default SideBar;
