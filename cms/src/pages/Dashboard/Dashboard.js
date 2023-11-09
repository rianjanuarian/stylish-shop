import React, { useState, useEffect } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import DashboardHeader from "../../components/DashboardHeader";

import { getUsers, userSelectors } from "../../redux/userSlice";
import {
  getTransactions,
  transactionSelectors,
} from "../../redux/transactionSlice";
import { getProducts, selectAllProducts } from "../../redux/productSlice";
import { useSelector, useDispatch } from "react-redux";

// Import icons
import profile from "../../assets/icons/user.svg";
import order from "../../assets/icons/order.svg";
import total_product from "../../assets/icons/total_product.svg";

// CSS
import "./Dashboard.css";

// Chart
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Doughnut } from "react-chartjs-2";
import "chart.js/auto";

ChartJS.register(ArcElement, Tooltip, Legend);

const Dashboard = () => {
  const dispatch = useDispatch();
  // User
  const users = useSelector(userSelectors.selectAll);
  // Transaction
  const transactions = useSelector(transactionSelectors.selectAll);
  // Product
  const products = useSelector(selectAllProducts);

  useEffect(() => {
    dispatch(getUsers());
    dispatch(getTransactions());
    dispatch(getProducts());
  }, [dispatch]);

  const [chartData, setChartData] = useState({
    labels: ["Total User", "Total Order", "Total Product"],
    datasets: [
      {
        label: "Data",
        data: [
          parseInt(users.length),
          parseInt(transactions.length),
          parseInt(products.length),
        ],
        backgroundColor: [
          "rgba(75, 192, 192, 0.6)",
          "rgba(255, 99, 132, 0.6)",
          "rgba(59, 77, 54, 0.2)",
        ],
      },
    ],
  });

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="dashboard-content">
          <DashboardHeader />
          <div className="container2">
            <div className="card">
              <div className="card-title">
                <img src={profile} alt="User" />
                <div>
                  <h2>Total User</h2>
                  <h3>{users.length}</h3>
                </div>
              </div>
            </div>
            <div className="card">
              <div className="card-title">
                <img src={order} alt="Transaction" />
                <div>
                  <h2>Total Order</h2>
                  <h3>{transactions.length}</h3>
                </div>
              </div>
            </div>
            <div className="card">
              <div className="card-title">
                <img src={total_product} alt="Product" />
                <div>
                  <h2>Total Product</h2>
                  <h3>{products.length}</h3>
                </div>
              </div>
            </div>
          </div>
          <div className="container-chart">
            <div className="chart">
              <Doughnut data={chartData} />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
