import React, { useState, useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { Link } from "react-router-dom";
import Swal from "sweetalert2";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import { deleteUsers, getUsers, userSelectors } from "../../redux/userSlice";
import { useSelector, useDispatch } from "react-redux";

import Loading from "../../helpers/Loading/Loading";
import empty from "../../assets/images/empty.png";

const UserList = () => {
  const dispatch = useDispatch();
  const users = useSelector(userSelectors.selectAll);
  const status = useSelector((state) => state.users.status);
  const error = useSelector((state) => state.users.error);

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

  return (
    <>
      <div className="dashboard-container">
        <SideBar menu={sidebar_menu} />
        <div className="dashboard-body">
          <div className="dashboard-content">
            <DashboardHeader />

            <div className="dashboard-content-container">
              <div className="dashboard-content-header">
                <h2>User List</h2>
                <Link to={"/addUser"} className="rows-btn" type="button">
                  Add Admin
                </Link>
              </div>
              <p>Role : </p>
              <div className="user-role">
                <Link to={"/adminList"}>
                  <button className="user-btn">Admin</button>
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
                <table>
                  <thead>
                    <tr>
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
                    </tr>
                  </thead>

                  <tbody>
                    {users.map((e, index) => (
                      <tr key={e.id}>
                        <td>
                          <span>{index + 1}</span>
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
                              src={`http://localhost:3000/uploads/${e.image}`}
                              style={{ width: "100px", height: "100px" }}
                              alt="user"
                            ></img>
                          </span>
                        </td>
                        <td>
                          <span>{e.role}</span>
                        </td>
                        <td>
                          <span>{e.address === null ? "-" : e.address}</span>
                        </td>
                        <td>
                          <span>{e.gender === null ? "-" : e.gender}</span>
                        </td>
                        <td>
                          <span>
                            {e.birthday ? e.birthday.slice(0, 10) : "-"}
                          </span>
                        </td>
                        <td>
                          <span>
                            {e.phone_number === null ? "-" : e.phone_number}
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
                            <Link to={`/updateUser/${e.id}`}>
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
    </>
  );
};

export default UserList;
