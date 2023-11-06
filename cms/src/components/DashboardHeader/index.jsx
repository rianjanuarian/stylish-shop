import React, { useEffect } from "react";

import "./styles.css";

import { useDispatch, useSelector } from "react-redux";
import { getUser } from "../../redux/userSlice";

function DashboardHeader() {
  const dispatch = useDispatch();
  const user = useSelector((state) => state.user);

  useEffect(() => {
    dispatch(getUser());
  }, [dispatch])



  return (
    <div className="dashbord-header-container">
      <a />

      <div className="dashbord-header-right">
        <h3>Hi {user.data.name}!</h3>
        <img
          className="dashbord-header-avatar"
          src={user.data.image}
        />
      </div>
    </div>
  );
}

export default DashboardHeader;
