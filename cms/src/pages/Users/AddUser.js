import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import { saveUsers } from "../../redux/userSlice";
import { useDispatch } from "react-redux";
import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
const AddUser = () => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const createUser = async (e) => {
    e.preventDefault();
  

    await dispatch(saveUsers({name:name,email:email,password:password}));
    navigate("/user");
  };
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add User</h1>
          <form onSubmit={createUser}>
            <label htmlFor="fname">Name</label>
            <input type="text" onChange={(e) => setName(e.target.value)} />
            <label htmlFor="fname">Email</label>
            <input type="text" onChange={(e) => setEmail(e.target.value)} />
            <label htmlFor="fname">Password</label>
            <input type="text" onChange={(e) => setPassword(e.target.value)} />

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default AddUser;
