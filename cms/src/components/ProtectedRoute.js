import { Navigate } from "react-router-dom";

export const ProtectedRoute = ({ children }) => {
  const isAuthenticated = localStorage.getItem("Authorization");

  if (!isAuthenticated) {
    return <Navigate to="/" />;
  }
  return children;
};
