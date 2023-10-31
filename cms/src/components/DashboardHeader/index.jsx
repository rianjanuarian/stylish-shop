import React from "react";

import "./styles.css";
import NotificationIcon from "../../assets/icons/notification.svg";
import SettingsIcon from "../../assets/icons/settings.svg";

function DashboardHeader() {
  return (
    <div className="dashbord-header-container">
      <a />

      <div className="dashbord-header-right">
        <img
          src={NotificationIcon}
          alt="notification-icon"
          className="dashbord-header-icon"
        />
        <img
          src={SettingsIcon}
          alt="settings-icon"
          className="dashbord-header-icon"
        />
        <img
          className="dashbord-header-avatar"
          src="https://reqres.in/img/faces/9-image.jpg"
        />
      </div>
    </div>
  );
}

export default DashboardHeader;
