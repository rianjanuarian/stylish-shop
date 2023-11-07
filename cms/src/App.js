import React from "react";
import "./styles/App.css";
import {
  LoginPage,
  Dashboard,
  Orders,
  Product,
  UserList,
  AddProduct,
  AddCategories,
  AddUser,
  Brand,
  Category,
  EditCategory,
  EditProduct,
  CustomerList,
  AdminList,
  Courier,
  UpdateUser
} from "./pages";

import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { ProtectedRoute } from "./components/ProtectedRoute";

const router = createBrowserRouter([
  {
    path: "/",
    element: <LoginPage />,
  },
  {
    path: "/dashboard",
    element: (
      <ProtectedRoute>
        <Dashboard />
      </ProtectedRoute>
    ),
  },
  {
    path: "/orders",
    element: (
      <ProtectedRoute>
        <Orders />
      </ProtectedRoute>
    ),
  },
  {
    path: "/locations",
    element: <div></div>,
  },
  {
    path: "/profile",
    element: <div></div>,
  },
  {
    path: "/user",
    element: <UserList />,
  },
  {
    path: "/products",
    element: (
      <ProtectedRoute>
        <Product />
      </ProtectedRoute>
    ),
  },
  {
    path: "/addProduct",
    element: (
      <ProtectedRoute>
        <AddProduct />
      </ProtectedRoute>
    ),
  },
  {
    path: "/addUser",
    element: (
      <ProtectedRoute>
        <AddUser />
      </ProtectedRoute>
    ),
  },
  {
    path: "/brands",
    element: (
      <ProtectedRoute>
        <Brand />
      </ProtectedRoute>
    ),
  },
  {
    path: "/categories",
    element: (
      <ProtectedRoute>
        <Category />
      </ProtectedRoute>
    ),
  },
  {
    path: "/categories/:id",
    element: <Category />,
  },
  {
    path: "/editCategory/:id",
    element: <EditCategory />,
  },
  {
    path: "/editProduct/:id",
    element: <EditProduct />,
  },
  {
    path: "/courier",
    element: (
      <ProtectedRoute>
        <Courier />
      </ProtectedRoute>
    ),
  },
  {
    path: "/adminList",
    element: <AdminList />,
  },
  {
    path: "/customerList",
    element: <CustomerList />,
  },
  {
    path: "/updateUser/:id",
    element: <UpdateUser />,
  },
]);

const App = () => {
  return <RouterProvider router={router} />;
};

export default App;
