import React, { useState } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import DashboardHeader from "../../components/DashboardHeader";

// CSS
import "./Dashboard.css";

// Chart
import { Bar, Doughnut } from "react-chartjs-2";
import "chart.js/auto";

const Dashboard = () => {
  const [chartData, setChartData] = useState({
    labels: ["Total User", "Total Order"],
    datasets: [
      {
        label: "Data",
        data: [100, 250], // Replace with your actual data
        backgroundColor: ["rgba(75, 192, 192, 0.6)", "rgba(255, 99, 132, 0.6)"],
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
                <img
                  src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  alt="No image"
                />
                <div>
                  <h2>Total User</h2>
                  <h3>200</h3>
                </div>
              </div>
            </div>
            <div className="card">
              <div className="card-title">
                <img
                  src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  alt="No image"
                />
                <div>
                  <h2>Total Order</h2>
                  <h3>200</h3>
                </div>
              </div>
            </div>
            <div className="card">
              <div className="card-title">
                <img
                  src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  alt="No image"
                />
                <div>
                  <h2>Visitor</h2>
                  <h3>200</h3>
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
