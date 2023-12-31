import React, { useEffect, useState } from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { useDispatch, useSelector } from "react-redux";
import {
  deleteCourier,
  getCouriers,
  selectAllCouriers,
} from "../../redux/courierSlice";
import DashboardHeader from "../../components/DashboardHeader";
import empty from "../../assets/images/empty.png";
import CourierModalAdd from "./CourierModalAdd";
import Swal from "sweetalert2";
import CourierModalEdit from "./CourierModalEdit";
import Loading from "../../helpers/Loading/Loading";

const Courier = () => {
  const couriers = useSelector(selectAllCouriers);
  const { error, loading } = useSelector((state) => state.couriers);
  const dispatch = useDispatch();
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;
  const [modalAdd, setModalAdd] = useState(false);
  const [modalEdit, setModalEdit] = useState(false);
  const [courierId, setCourierId] = useState(0);

  const toggleModalAdd = () => setModalAdd(!modalAdd);
  const toggleModalEdit = () => setModalEdit(!modalEdit);
  const priceConverter = (price) => {
    const formattedPrice = new Intl.NumberFormat("id-ID", {
      style: "currency",
      currency: "IDR",
    }).format(price);

    return <div>{formattedPrice}</div>;
  };
  useEffect(() => {
    dispatch(getCouriers());
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
        dispatch(deleteCourier(id))
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
    setCourierId(id);
    toggleModalEdit();
  };
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = couriers.slice(indexOfFirstItem, indexOfLastItem);

  const totalPages = Math.ceil(couriers.length / itemsPerPage);

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
                <h2>Courier List</h2>
                <button className="rows-btn" onClick={toggleModalAdd}>
                  Add Courier
                </button>
              </div>
              {loading ? (
                <div className="loading-animate">
                  <Loading />
                </div>
              ) : error ? (
                <p>{error}</p>
              ) : couriers && couriers.length !== 0 ? (
                <>
                  <table>
                    <thead>
                      <tr>
                        <th>No.</th>
                        <th>NAME</th>
                        <th>PRICE</th>
                        <th>IMAGE</th>
                        <th>ACTION</th>
                      </tr>
                    </thead>
                    <tbody>
                      {currentItems.map((courier, index) => (
                        <tr key={courier.id}>
                          <td>
                            <span>
                              {index + 1 + itemsPerPage * (currentPage - 1)}
                            </span>
                          </td>
                          <td>
                            <span>{courier.name}</span>
                          </td>
                          <td>
                            <span>{priceConverter(courier.price)}</span>
                          </td>
                          <td>
                            <span>
                              {courier.image.startsWith("http") ? (
                                <img
                                  src={courier.image}
                                  style={{ width: "100px", height: "100px" }}
                                  alt="courier"
                                />
                              ) : (
                                ({
                                  /* stylish-shop/brands/88a61745866d5fa3d20db2658ca7466f */
                                },
                                (
                                  <img
                                    src={`https://storage.cloud.google.com/${courier.image}`}
                                    style={{ width: "100px", height: "100px" }}
                                    alt="courier"
                                  />
                                ))
                              )}
                            </span>
                          </td>
                          <td>
                            <div>
                              <button
                                onClick={() => deletes(courier.id)}
                                className="action-btn-delete"
                              >
                                Delete
                              </button>
                              <button
                                className="action-btn-update"
                                onClick={() => update(courier.id)}
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
      {modalAdd && <CourierModalAdd toggleModalAdd={toggleModalAdd} />}
      {modalEdit && (
        <CourierModalEdit
          toggleModalEdit={toggleModalEdit}
          courierId={courierId}
        />
      )}
    </>
  );
};

export default Courier;
