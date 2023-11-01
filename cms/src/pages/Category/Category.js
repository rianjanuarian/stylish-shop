import React, { useState, useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { Link } from "react-router-dom";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import { useSelector, useDispatch } from "react-redux";
import { getCategories, categorySelectors } from "../../features/categorySlice";
const Category = () => {
  const dispatch = useDispatch();
  const categories = useSelector(categorySelectors.selectAll);

  useEffect(() => {
    dispatch(getCategories());
  }, [dispatch]);

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="dashboard-content">
          <DashboardHeader />

          <div className="dashboard-content-container">
            <div className="rows">
              <Link to={"/addCategory"} className="rows-btn" type="button">
                Add Category
              </Link>
            </div>

            <div className="dashboard-content-header">
              <h2>Categories List</h2>
            </div>

            <table>
              <thead>
                <th>No.</th>
                <th>NAME</th>
                <th>ACTION</th>
              </thead>

              {categories.length !== 0 ? (
                <tbody>
                  {categories.map((e, index) => (
                    <tr key={e.id}>
                      <td>
                        <span>{index + 1}</span>
                      </td>
                      <td>
                        <span>{e.name}</span>
                      </td>
                    </tr>
                  ))}
                </tbody>
              ) : null}
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Category;
