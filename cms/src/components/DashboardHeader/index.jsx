import React, { useEffect } from "react";
import "./styles.css";
import { useDispatch, useSelector } from "react-redux";
import { getUser } from "../../redux/currentUserSlice";

function DashboardHeader() {
  const dispatch = useDispatch();
  const currentUser = useSelector((state) => state.currentUser);

  useEffect(() => {
    if (!currentUser.data) {
      const accessToken = localStorage.getItem('Authorization');
      dispatch(getUser(accessToken));
    }
  }, [dispatch, currentUser.data]);

  return (
    <div className="dashbord-header-container">
      <div className="dashbord-header-right">
        {currentUser.data && <>
          <h3>Hi {currentUser.data.name}!</h3>
          <img
            className="dashbord-header-avatar"
            src={currentUser.data.image}
            alt="Profile"
          />
        </>}
      </div>
    </div>
  );
}

export default DashboardHeader;
