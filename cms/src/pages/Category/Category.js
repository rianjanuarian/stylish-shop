import React, { useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { Link } from "react-router-dom";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import Swal from "sweetalert2";
import { useSelector, useDispatch } from "react-redux";

import empty from "../../assets/images/empty.png";

import {
  getCategories,
  categorySelectors,
  deleteCategories,
} from "../../redux/categorySlice";



const Category = () => {
  const dispatch = useDispatch();
  const categories = useSelector(categorySelectors.selectAll);

  useEffect(() => {
    dispatch(getCategories());
  }, [dispatch]);
  const deletes = (id) => {
    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, delete it!",
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire("Deleted!", "Your category has been deleted.", "success");
        dispatch(deleteCategories(id));
      }
    });
  };
  return (
    <>
      <div className="dashboard-container">
        <SideBar menu={sidebar_menu} />
        <div className="dashboard-body">
          <div className="dashboard-content">
            <DashboardHeader />

            <div className="dashboard-content-container">
              <div className="dashboard-content-header">
                <h2>Categories List</h2>
                <Link to={"/addCategory"} className="rows-btn" type="button">
                Add Category
              </Link>
              </div>
              {categories.length !== 0 ? (
                <table>
                  <thead>
                    <th>No.</th>
                    <th>NAME</th>
                    <th>ACTION</th>
                  </thead>

                  <tbody>
                    {categories.map((e, index) => (
                      <tr key={e.id}>
                        <td>
                          <span>{index + 1}</span>
                        </td>
                        <td>
                          <span>{e.name}</span>
                        </td>
                        <td>
                          <div>
                            <button
                              onClick={() => deletes(e.id)}
                              className="action-btn-delete"
                            >
                              Delete
                            </button>
                            <Link to={`/editCategory/${e.id}`}>
                              <button className="action-btn-update">
                                Update
                              </button>
                            </Link>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              ) : (
                <div className="empty">
                  <img src={empty} alt="" />
                  <h1>The table is empty! Try adding some!</h1>
                </div>
              )}
              ;
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Category;
