import "./styles.css";

function DashboardHeader() {
  const storedCurrentUser = localStorage.getItem("currentUser");
  const currentUser = JSON.parse(storedCurrentUser);

  return (
    <div className="dashbord-header-container">
      <div className="dashbord-header-right">
        {currentUser && (
          <>
            <h3>Hi {currentUser.name}!</h3>
            <img
              className="dashbord-header-avatar"
              src={!currentUser.image.startsWith("http") ? `http://localhost:3000/uploads/${currentUser.image}` : `${currentUser.image}`}
              alt="Profile"
            />
          </>
        )}
      </div>
    </div>
  );
}

export default DashboardHeader;
