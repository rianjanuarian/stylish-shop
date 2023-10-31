import React from "react";
import "./login.css";
const LoginPage = () => {
  return (
    <div className="login-page">
      <div className="login-container">
        <div className="card">
          <h1 className="textcenter">Login</h1>
          <form>
            <input type="text" placeholder="Username" />
            <input type="password" placeholder="Password" />
            <button className="btn-login" type="submit">
              Login
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
