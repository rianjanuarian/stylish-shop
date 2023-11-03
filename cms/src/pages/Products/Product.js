import React, { useState, useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { useSelector, useDispatch } from "react-redux";
import { Link } from "react-router-dom";

import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";

import { productSelectors, getProducts } from "../../redux/productSlice";
const Product = () => {
  const products = useSelector(productSelectors.selectAll);

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(getProducts());
  }, [dispatch]);

  // Change Page

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="dashboard-content">
          <DashboardHeader />

          <div className="dashboard-content-container">
            <div className="rows">
              <Link to={"/addProduct"} className="rows-btn" type="button">
                Add Product
              </Link>
            </div>

            <div className="dashboard-content-header">
              <h2>Product List</h2>
            </div>

            <table>
              <thead>
                <th>No.</th>
                <th>NAME</th>
                <th>PRICE</th>
                <th>DESCRIPTION</th>
                <th>STOCK</th>
                <th>IMAGE</th>
                <th>COLOR</th>
                <th>CATEGORIES</th>
                <th>BRAND</th>
                <th>ACTION</th>
              </thead>

              {products.length !== 0 ? (
                <tbody>
                  {products.map((e, index) => (
                    <tr key={e.id}>
                      <td>
                        <span>{index + 1}</span>
                      </td>
                      <td>
                        <span>{e.name}</span>
                      </td>
                      <td>
                        <span>${e.price}</span>
                      </td>
                      <td>
                        <span>{e.description}</span>
                      </td>
                      <td>
                        <span>{e.stock}</span>
                      </td>
                      <td>
                        <span>{e.image}</span>
                      </td>
                      <td>
                        {e.color === null ? (
                          <span>No color</span>
                        ) : (
                          <span>{e.color}</span>
                        )}
                      </td>
                      <td>
                        {e.categories.map((el) => (
                          <span>{el.name}</span>
                        ))}
                      </td>
                      <td>
                        {e.brands.map((el) => (
                          <span>{el.name}</span>
                        ))}
                      </td>
                    </tr>
                  ))}
                </tbody>
              ) : (
                <h3>No data</h3>
              )}
            </table>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Product;
