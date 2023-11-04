import React, { useState, useEffect } from "react";
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

import {
  getCategoriesTest,
  deleteCategory,
} from "../../redux/categorySliceTest";

import ModalAddCategory from "./ModalAddCategory";
import ModalEditCategory from "./ModalEditCategory";

const Category = () => {
  const [modalAdd, setModalAdd] = useState(false);
  const [modalEdit, setModalEdit] = useState(false);
  const [categoryId, setCategoryId] = useState(0);

  const dispatch = useDispatch();
  const category = useSelector((state) => state.categoryTest);
  const categories = category.categories;

  const toggleModalAdd = () => {
    setModalAdd(!modalAdd);
  };

  const toggleModalEdit = (id) => {
    setCategoryId(id);
    setModalEdit(!modalEdit);
  };

  useEffect(() => {
    dispatch(getCategoriesTest());
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
        dispatch(deleteCategory(id));
        Swal.fire("Deleted!", "Your category has been deleted.", "success");
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
                <button onClick={toggleModalAdd} className="rows-btn">
                  Add Category
                </button>
              </div>
              {category.loading === "pending" ? (
                <div className="empty">
                  <img src={empty} alt="" />
                  <h1>Loading...</h1>
                </div>
              ) : category.loading === "rejected" ? (
                <div className="empty">
                  <img src={empty} alt="" />
                  <h1>Error: {category.error.message}</h1>
                </div>
              ) : (
                <>
                  {categories.length !== 0 ? (
                    <table>
                      <thead>
                        <tr>
                          <th>No.</th>
                          <th>NAME</th>
                          <th>ACTION</th>
                        </tr>
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
                                <button
                                  className="action-btn-update"
                                  onClick={() => {
                                    toggleModalEdit(e.id);
                                  }}
                                >
                                  Update
                                </button>
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
                </>
              )}
            </div>
          </div>
        </div>
      </div>
      {modalAdd && <ModalAddCategory toggleModalAdd={toggleModalAdd} />}
      {modalEdit && (
        <ModalEditCategory
          toggleModalEdit={toggleModalEdit}
          categoryId={categoryId}
        />
      )}
    </>
  );
};

export default Category;
