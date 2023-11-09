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

import AddUser from "./AddUser";
import UpdateUser from "./UpdateUser";


const UserList = () => {
  const dispatch = useDispatch();
  const users = useSelector(userSelectors.selectAll);
  const status = useSelector((state) => state.users.status);
  const error = useSelector((state) => state.users.error);
  const [modalAdd, setModalAdd] = useState(false)
  const [modalEdit, setModalEdit] = useState(false);
  const [userId, setUserId] = useState(0)
  const toggleModalAdd = () => setModalAdd(!modalAdd);
  const toggleModalEdit = () => setModalEdit(!modalEdit);
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
                <button className="rows-btn" type="button" onClick={toggleModalAdd}>
                  Add Admin
                </button>
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
                    {users.map((user, index) => (
                      <tr key={user.id}>
                        <td>
                          <span>{index + 1}</span>
                        </td>
                        <td>
                          <span>{user.name}</span>
                        </td>
                        <td>
                          <span>{user.email}</span>
                        </td>
                        <td>
                          <span>
                            <img
                              src={user.image && !user.image.startsWith('http') ? `http://localhost:3000/uploads/${user.image}` : `${user.image}`}
                              style={{ width: "100px", height: "100px" }}
                              alt="user"
                            ></img>
                          </span>
                        </td>
                        <td>
                          <span>{user.role}</span>
                        </td>
                        <td>
                          <span>{user.address === null ? "-" : user.address}</span>
                        </td>
                        <td>
                          <span>{user.gender === null ? "-" : user.gender === 'man' ? 'Male': 'Female'}</span>
                        </td>
                        <td>
                          <span>
                            {user.birthday ? user.birthday.slice(0, 10) : "-"}
                          </span>
                        </td>
                        <td>
                          <span>
                            {user.phone_number === null ? "-" : user.phone_number}
                          </span>
                        </td>
                        <td>
                          <div>
                            <button
                              onClick={() => deletes(user.id)}
                              className="action-btn-delete"
                            >
                              Delete
                            </button>
                            
                              <button className="action-btn-update" 
                              onClick={() => update(user.id)}>
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
            </div>
          </div>
        </div>
      </div>
      {modalAdd && <AddUser toggleModalAdd={toggleModalAdd}/>}
      {modalEdit && <UpdateUser toggleModalEdit={toggleModalEdit} userId={userId}/>}
    </>
  );
};

export default UserList;
