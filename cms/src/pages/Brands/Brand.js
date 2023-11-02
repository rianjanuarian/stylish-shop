import React, { useState, useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { Link } from "react-router-dom";

import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";

import { brandSelectors, getBrands } from "../../redux/brandSlice";
import { useSelector, useDispatch } from "react-redux";
const Brand = () => {
  const dispatch = useDispatch();
  const brands = useSelector(brandSelectors.selectAll);
  useEffect(() => {
    dispatch(getBrands());
  }, [dispatch]);

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="dashboard-content">
          <DashboardHeader />

          <div className="dashboard-content-container">
            <div className="rows">
              <Link to={"/addBrand"} className="rows-btn" type="button">
                Add Brand
              </Link>
            </div>

            <div className="dashboard-content-header">
              <h2>Brand List</h2>
            </div>

            <table>
              <thead>
                <th>No.</th>
                <th>NAME</th>
                <th>IMAGE</th>
                <th>ACTION</th>
              </thead>

              {brands.length !== 0 ? (
                <tbody>
                  {brands.map((e, index) => (
                    <tr key={e.id}>
                      <td>
                        <span>{index + 1}</span>
                      </td>
                      <td>
                        <span>{e.name}</span>
                      </td>
                      <td>
                        <span>{e.image}</span>
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

export default Brand;
