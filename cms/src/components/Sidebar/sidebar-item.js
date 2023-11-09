import React, { useState } from "react";
import { Link } from "react-router-dom";
import CustomIcon from "./custom-icon";

import "./sidebar.css";

const SideBarItem = ({ item, active }) => {
  const [hover, setHover] = useState(false);
  return (
    <Link
      to={item.path}
      className={"sidebar-item"}
      // className={active ? "sidebar-item-active" : "sidebar-item"}
    >
      <CustomIcon
        key={item.id}
        icon={item.icon}
        className="sidebar-item-icon"
      />

      <span className="sidebar-item-label">{item.title}</span>
    </Link>
  );
};
export default SideBarItem;
