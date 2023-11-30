import React, { useEffect, useState } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import Swal from "sweetalert2";
import {
  getBrands,
  deleteBrand,
  selectAllBrands,
} from "../../redux/brandSlice";
import { useSelector, useDispatch } from "react-redux";
import empty from "../../assets/images/empty.png";
import BrandModalAdd from "./BrandModalAdd";
import BrandModalEdit from "./BrandModalEdit";
import Loading from "../../helpers/Loading/Loading";

const Brand = () => {
  const brands = useSelector(selectAllBrands);
  const { error, loading } = useSelector((state) => state.brands);
  const dispatch = useDispatch();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;

  const [modalAdd, setModalAdd] = useState(false);
  const [modalEdit, setModalEdit] = useState(false);
  const [brandId, setBrandId] = useState(0);

  const toggleModalAdd = () => setModalAdd(!modalAdd);
  const toggleModalEdit = () => setModalEdit(!modalEdit);

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
        dispatch(deleteBrand(id))
          .unwrap()
          .then((data) => {
            Swal.fire({
              icon: "success",
              title: data.message,
              showConfirmButton: false,
              timer: 1500,
            });
          })
          .catch((err) => {
            Swal.fire({
              icon: "error",
              title: "Error",
              text: err.message,
              footer: err.stack,
            });
          });
      }
    });
  };

  const update = (id) => {
    setBrandId(id);
    toggleModalEdit();
  };
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = brands.slice(indexOfFirstItem, indexOfLastItem);

  const totalPages = Math.ceil(brands.length / itemsPerPage);

  const paginate = (pageNumber) => {
    const lastPageItemIndex = pageNumber * itemsPerPage;

    const nextPage = Math.min(pageNumber, totalPages);
    setCurrentPage(nextPage);
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
                <button className="rows-btn" onClick={toggleModalAdd}>
                  Add Brand
                </button>
              </div>
              {loading ? (
                <div className="loading-animate">
                  <Loading />
                </div>
              ) : error ? (
                <p>{error}</p>
              ) : brands.length !== 0 ? (
                <>
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
                      {currentItems.map((e, index) => (
                        <tr key={e.id}>
                          <td>
                            <span>
                              {index + 1 + itemsPerPage * (currentPage - 1)}
                            </span>
                          </td>
                          <td>
                            <span>{e.name}</span>
                          </td>
                          <td>
                            <span>
                              {
                                <img
                                  src={
                                    e.image === null
                                      ? `https://cdn.discordapp.com/attachments/1076057192945434624/1179451262232707223/1665px-No-Image-Placeholder.png?ex=6579d496&is=65675f96&hm=c3fb9d7bd5f473ec49302f1dc8dd5c85a75d389366ccd692c00c550e6afaf699&`
                                      : e.image.includes("placeholder")
                                      ? e.image
                                      : `https://storage.cloud.google.com/${e.image}`
                                  }
                                  style={{ width: "100px", height: "100px" }}
                                  alt="Brand"
                                ></img>
                              }
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
                                onClick={() => update(e.id)}
                              >
                                Update
                              </button>
                            </div>
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                  <div className="pagination">
                    {Array.from({ length: totalPages }).map((_, index) => (
                      <button
                        key={index}
                        className={`page-btn ${
                          index + 1 === currentPage ? "active" : ""
                        }`}
                        onClick={() => paginate(index + 1)}
                      >
                        {index + 1}
                      </button>
                    ))}
                  </div>
                </>
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
      {modalAdd && <BrandModalAdd toggleModalAdd={toggleModalAdd} />}
      {modalEdit && (
        <BrandModalEdit toggleModalEdit={toggleModalEdit} brandId={brandId} />
      )}
    </>
  );
};

export default Brand;
