import React, { useState, useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { Link } from "react-router-dom";
import Swal from "sweetalert2";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import { deleteUsers, getUsers, userSelectors, sortByRole } from "../../redux/userSlice";
import { useSelector, useDispatch } from "react-redux";

import Loading from "../../helpers/Loading/Loading";
import empty from "../../assets/images/empty.png";
import AddUser from "./AddUser";
import UpdateUser from "./UpdateUser";
const AdminList = () => {
  const dispatch = useDispatch();
  const users = useSelector(userSelectors.selectAll);
  const status = useSelector((state) => state.users.status);
  const error = useSelector((state) => state.users.error);
  const [modalAdd, setModalAdd] = useState(false)
  const [modalEdit, setModalEdit] = useState(false);
  const [userId, setUserId] = useState(0)
  const toggleModalAdd = () => setModalAdd(!modalAdd);
  const toggleModalEdit = () => setModalEdit(!modalEdit);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 5;
  useEffect(() => {
    dispatch(getUsers());
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
        Swal.fire("Deleted!", "User has been deleted.", "success");
        dispatch(deleteUsers(id));
      }
    });
  };
  const update = (id) => {
    setUserId(id);
    toggleModalEdit();
  };
  const adminRole = users.filter((user) => user.role === "admin");
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = adminRole.slice(indexOfFirstItem, indexOfLastItem);

  const totalPages = Math.ceil(adminRole.length / itemsPerPage);

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
                <h2>Admin List</h2>
                <button className="rows-btn" type="button" onClick={toggleModalAdd}>
                  Add Admin
                </button>
              </div>
              <p>Role : </p>
              <div className="user-role">
                <Link to={"/user"}>
                <button className="user-btn">All User</button>
                </Link>
                <Link to={"/customerList"}>
                <button className="user-btn">User</button>
                </Link>
              </div>
              {status === "loading" ? (
                <div className="loading-animate">
                  <Loading></Loading>
                </div>
              ) : status === "rejected" ? (
                <p>{error}</p>
              ) : users.length !== 0 ? (
                <><table>
                      <thead>
                        <th>No.</th>
                        <th>NAME</th>
                        <th>EMAIL</th>
                        <th>IMAGE</th>
                        <th>ROLE</th>
                        <th>ADDRESS</th>
                        <th>GENDER</th>
                        <th>BIRTHDAY</th>
                        <th>PHONE</th>
                        <th>ACTION</th>
                      </thead>

                      <tbody>
                        {currentItems.map((e, index) => (
                          <tr key={e.id}>
                            <td>
                              <span>{index + 1 + itemsPerPage * (currentPage - 1)}</span>
                            </td>
                            <td>
                              <span>{e.name}</span>
                            </td>
                            <td>
                              <span>{e.email}</span>
                            </td>
                            <td>
                              <span>
                                <img
                                  src={
                                    e.image === null
                                      ? `https://cdn.discordapp.com/attachments/1076057192945434624/1179451262232707223/1665px-No-Image-Placeholder.png?ex=6579d496&is=65675f96&hm=c3fb9d7bd5f473ec49302f1dc8dd5c85a75d389366ccd692c00c550e6afaf699&`
                                      : `https://storage.cloud.google.com/${e.image}`
                                  }
                                  style={{ width: "100px", height: "100px" }}
                                  alt="Admin"
                                ></img>
                              </span>
                            </td>
                            <td>
                              <span>{e.role}</span>
                            </td>
                            <td>
                              <span>{e.address}</span>
                            </td>
                            <td>
                              <span>{e.gender === null ? "-" : e.gender === 'man' ? 'Male' : 'Female'}</span>
                            </td>
                            <td>
                              <span>{e.birthday ? e.birthday.slice(0, 10) : ""}</span>
                            </td>
                            <td>
                              <span>{e.phone_number}</span>
                            </td>
                            <td>
                              <div>
                                <button
                                  onClick={() => deletes(e.id)}
                                  className="action-btn-delete"
                                >
                                  Delete
                                </button>
                                <button className="action-btn-update"
                                  onClick={() => update(e.id)}>
                                  Update
                                </button>
                              </div>
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table><div className="pagination">
                        {Array.from({ length: totalPages }).map((_, index) => (
                          <button
                            key={index}
                            className={`page-btn ${index + 1 === currentPage ? "active" : ""}`}
                            onClick={() => paginate(index + 1)}
                          >
                            {index + 1}
                          </button>
                        ))}
                      </div></>
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
      {modalAdd && <AddUser toggleModalAdd={toggleModalAdd}/>}
      {modalEdit && <UpdateUser toggleModalEdit={toggleModalEdit} userId={userId}/>}
    </>
  );
};

export default AdminList;