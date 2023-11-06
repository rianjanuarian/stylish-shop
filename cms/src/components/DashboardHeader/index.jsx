import React, { useEffect } from "react";
import "./styles.css";
import { useDispatch, useSelector } from "react-redux";
import { getUser } from "../../redux/userSlice";

function DashboardHeader() {
  const dispatch = useDispatch();
  const user = useSelector((state) => state.user);

  useEffect(() => {
    if (!user.data) {
      const accessToken = localStorage.getItem('Authorization');
      dispatch(getUser(accessToken));
    }
  }, [dispatch, user.data]);

  return (
    <div className="dashbord-header-container">
      <div className="dashbord-header-right">
        {user.data && <>
          <h3>Hi {user.data.name}!</h3>
          <img
            className="dashbord-header-avatar"
            src={user.data.image}
            alt="Profile"
          />
        </>}
      </div>
    </div>
  );
}

export default DashboardHeader;
