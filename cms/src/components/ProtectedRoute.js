import { Navigate } from "react-router-dom";

export const ProtectedRoute = ({ children }) => {
  const isAuthenticated = localStorage.getItem("access_token");

  if (isAuthenticated) {
    // nanti ta setel
    return <Navigate to="/" />;
  }
  return children;
};
