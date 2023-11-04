import React, { useEffect, useState } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import Swal from "sweetalert2";
import { getBrandsTest, deleteBrand } from "../../redux/brandSliceTest";
import { useSelector, useDispatch } from "react-redux";
import empty from "../../assets/images/empty.png";
import ModalAddBrand from "./ModalAddBrand";
import ModalEditbrand from "./ModalEditbrand";

const Brand = () => {
  const [modalAdd, setModalAdd] = useState(false);
  const [modalEdit, setModalEdit] = useState(false);
  const [brandId, setBrandId] = useState(0);
  const dispatch = useDispatch();

  const brand = useSelector((state) => state.brandTest);
  const brands = brand.brands;

  const toggleModalAdd = () => {
    setModalAdd(!modalAdd);
  };

  const toggleModalEdit = (id) => {
    setBrandId(id);
    setModalEdit(!modalEdit);
  };

  useEffect(() => {
    dispatch(getBrandsTest());
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
        dispatch(deleteBrand(id));
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
                <button onClick={toggleModalAdd} className="rows-btn">
                  Add Brand
                </button>
              </div>
              {brand.loading === "pending" ? (
                <div className="empty">
                  <img src={empty} alt="" />
                  <h1>Loading...</h1>
                </div>
              ) : brand.loading === "rejected" ? (
                <div className="empty">
                  <img src={empty} alt="" />
                  <h1>Error: {brand.error.message}</h1>
                </div>
              ) : (
                <>
                  {brands.length !== 0 ? (
                    <table>
                      <thead>
                        <tr>
                          <th>No.</th>
                          <th>NAME</th>
                          <th>IMAGE</th>
                          <th>ACTION</th>
                        </tr>
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
      {modalAdd && <ModalAddBrand toggleModalAdd={toggleModalAdd} />}
      {modalEdit && (
        <ModalEditbrand toggleModalEdit={toggleModalEdit} brandId={brandId} />
      )}
    </>
  );
};

export default Brand;
