import React, { useState, useEffect } from "react";
import "./login.css";
import Swal from "sweetalert2";
import { useDispatch, useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import { login } from "../../redux/authSlice";

const LoginPage = () => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const auth = useSelector((state) => state.auth);

  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData({
      ...formData,
      [id]: value,
    });
  };

  const handleLogin = (e) => {
    e.preventDefault();
    dispatch(login(formData));
  };

  useEffect(() => {
    if (auth.error) {
      Swal.fire({
        icon: "error",
        title: "Error",
        text: auth.error.message,
        footer: auth.error.stack,
      });
    }
  }, [auth.error]);

  useEffect(() => {
    if (localStorage.getItem("Authorization")) {
      navigate("/dashboard");
    }
  }, [auth, navigate]);

  return (
    <div className="login-body">
      <div className="main">
        <input type="checkbox" id="chk" aria-hidden="true" />

        <div className="login">
          <form onSubmit={handleLogin}>
            <label className="label-login" htmlFor="chk" aria-hidden="true">
              Login
            </label>
            <input
              className="input-login"
              type="email"
              name="email"
              placeholder="Email"
              id="email"
              onChange={handleChange}
              required
            />
            <input
              className="input-login"
              type="Password"
              name="password"
              placeholder="Password"
              id="password"
              onChange={handleChange}
              required
            />
            <button className="button-login">Login</button>
          </form>
        </div>

        <div className="signup">
          <form>
            <label className="label-login" htmlFor="chk" aria-hidden="true">
              Sign Up
            </label>
            <input
              className="input-login"
              name="username"
              placeholder="Username"
              required
            />
            <input
              className="input-login"
              type="email"
              name="email"
              placeholder="Email"
              required
            />
            <input
              className="input-login"
              type="Password"
              name="pswd"
              placeholder="Password"
              required
            />
            <button className="button-login" type="submit">
              Sign Up
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
