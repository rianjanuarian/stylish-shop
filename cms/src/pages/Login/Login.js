import React, { useState, useEffect } from "react";
import "./login.css";
import Swal from "sweetalert2";
import { useDispatch, useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import { login } from "../../redux/authSlice";

// React Icons
import { FaUser, FaLock } from "react-icons/fa";

// Images
import wave from "../../assets/images/wave.png";
import bg from "../../assets/images/bg.svg";
import avatar from "../../assets/images/avatar.svg";

const LoginPage = () => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const auth = useSelector((state) => state.auth);

  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });

  console.log(formData);

  const [isEmailFocused, setIsEmailFocused] = useState(false);
  const [isPasswordFocused, setIsPasswordFocused] = useState(false);

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

  const remcl = (event, inputRef, setIsFocused) => {
    if (event.target.value === "") {
      setIsFocused(false);
    }
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
    <>
      <img className="wave" src={wave} alt="Wave" />
      <div className="container">
        <div className="img">
          <img src={bg} alt="Background" />
        </div>
        <div className="login-content">
          <form onSubmit={handleLogin}>
            <img src={avatar} alt="Avatar" />
            <h2 className="title">Welcome</h2>
            <div className={`input-div one ${isEmailFocused ? "focus" : ""}`}>
              <div className="i">
                <i>
                  <FaUser />
                </i>
              </div>
              <div className="div">
                <h5>Email</h5>
                <input
                  type="email"
                  className="input"
                  name="email"
                  id="email"
                  onChange={handleChange}
                  onFocus={() => setIsEmailFocused(true)}
                  onBlur={(e) => remcl(e, formData.email, setIsEmailFocused)}
                  required
                />
              </div>
            </div>
            <div
              className={`input-div pass ${isPasswordFocused ? "focus" : ""}`}
            >
              <div className="i">
                <i>
                  <FaLock />
                </i>
              </div>
              <div className="div">
                <h5>Password</h5>
                <input
                  type="password"
                  className="input"
                  name="password"
                  id="password"
                  onChange={handleChange}
                  onFocus={() => setIsPasswordFocused(true)}
                  onBlur={(e) =>
                    remcl(e, formData.password, setIsPasswordFocused)
                  }
                  required
                />
              </div>
            </div>
            <a href="/">Forgot Password?</a>
            <button type="submit" className="btn">
              Login
            </button>
          </form>
        </div>
      </div>
    </>
  );
};

export default LoginPage;
