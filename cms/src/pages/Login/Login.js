import React from "react";
import "./login.css";
const LoginPage = () => {
  return (
    <div className="login-body">
    <div className="main">
      <input type="checkbox" id="chk" aria-hidden="true" />

      <div className="signup">
        <form>
          <label className="label-login" for="chk" aria-hidden="true">
            Sign up
          </label>
          <input className="input-login" name="username" placeholder="Username" required />
          <input className="input-login" type="email" name="email" placeholder="Email" required />
          <input className="input-login" type="Password" name="pswd" placeholder="Password" required />
          <button className="button-login" >Sign up</button>
        </form>
      </div>

      <div className="login">
        <form>
          <label className="label-login" for="chk" aria-hidden="true">
            Login
          </label>
          <input className="input-login" type="email" name="email" placeholder="Email" required />
          <input className="input-login" type="Password" name="pswd" placeholder="Password" required />
          <button className="button-login" >Login</button>
        </form>
      </div>
    </div>
    </div>
  );
};

export default LoginPage;
