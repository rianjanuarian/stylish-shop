import "./styles.css";
import LogoutIcon from "../../assets/icons/logout.svg";
import { useDispatch } from "react-redux";
import { useLocation, useNavigate } from "react-router-dom";
import Swal from "sweetalert2";
import { logout } from "../../redux/authSlice";
function DashboardHeader() {
  const storedCurrentUser = localStorage.getItem("currentUser");
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const currentUser = JSON.parse(storedCurrentUser);
  const handleLogout = () => {
    Swal.fire({
      title: "Are you sure you want to logged out?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, logout!",
    }).then((result) => {
      if (result.isConfirmed) {
        dispatch(logout()).then(() => {
          navigate("/");
        });
      }
    });
  };
  return (
    <div className="dashbord-header-container">
      <div className="dashbord-header-right">
        {currentUser && (
          <>
            <h3>Hi {currentUser.name}!</h3>
            <div className="dropdown">
              <div>
                <img
                  className="dashbord-header-avatar"
          
                  src={`https://storage.cloud.google.com/${currentUser.image}`}
                  // src={!currentUser.image.startsWith("https") ? `https://stylish-shop.vercel.app/tmp/${currentUser.image}` : `${currentUser.image}`}
                  alt="Profile"
                ></img>
                <div className="dropdown-content">
                  <a onClick={handleLogout}>Logout</a>
                  {/* <img
              src={LogoutIcon}
              alt="icon-logout"
              className="sidebar-item-icon"
            />  */}
                </div>
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

{
  /* <div class="dropdown">
  <button class="dropbtn">Dropdown</button>
  <div class="dropdown-content">
    <a href="#">Link 1</a>
    <a href="#">Link 2</a>
    <a href="#">Link 3</a>
  </div>
</div> */
}
export default DashboardHeader;
