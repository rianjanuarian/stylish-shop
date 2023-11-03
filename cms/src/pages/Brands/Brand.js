import React, { useEffect, useState } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { Link } from "react-router-dom";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import Swal from "sweetalert2";
import {
  brandSelectors,
  getBrands,
  deleteBrands,
} from "../../redux/brandSlice";
import { useSelector, useDispatch } from "react-redux";
import empty from "../../assets/images/empty.png";
import ModalAddBrand from "./ModalAddBrand";

const Brand = () => {
  const [modal, setModal] = useState(false);
  const dispatch = useDispatch();
  const brands = useSelector(brandSelectors.selectAll);

  const toggleModal = () => {
    setModal(!modal);
  };

  useEffect(() => {
    dispatch(getBrands());
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
        Swal.fire("Deleted!", "Your brand has been deleted.", "success");
        dispatch(deleteBrands(id));
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
                <h2>Brand List</h2>
                <button onClick={toggleModal} className="rows-btn">
                  Add Brand
                </button>
              </div>
              {brands.length !== 0 ? (
                <table>
                  <thead>
                    <th>No.</th>
                    <th>NAME</th>
                    <th>IMAGE</th>
                    <th>ACTION</th>
                  </thead>
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
                          <span>
                            <img
                              src={`http://localhost:3000/uploads/${e.image}`}
                              style={{ width: "200px", height: "200px" }}
                              alt="Brand"
                            ></img>
                          </span>
                        </td>
                        <td>
                          <div>
                            <button
                              onClick={() => deletes(e.id)}
                              className="action-btn-delete"
                            >
                              Delete
                            </button>
                            <Link to={`/editBrand/${e.id}`}>
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
            </div>
          </div>
        </div>
      </div>
      {modal && <ModalAddBrand toggleModal={toggleModal} />}
    </>
  );
};

export default Brand;
