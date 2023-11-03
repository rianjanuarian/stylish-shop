import React from "react";
import "./styles/App.css";
import {
  LoginPage,
  Dashboard,
  Orders,
  Product,
  UserList,
  AddProduct,
  AddBrand,
  AddCategories,
  AddUser,
  Brand,
  Category,
} from "./pages";

import { createBrowserRouter, RouterProvider } from "react-router-dom";
import { ProtectedRoute } from "./components/ProtectedRoute";

function App() {
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
      element: (
        <ProtectedRoute>
          <UserList />
        </ProtectedRoute>
      ),
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
      path: "/addBrand",
      element: (
        <ProtectedRoute>
          <AddBrand />
        </ProtectedRoute>
      ),
    },
    {
      path: "/addCategory",
      element: (
        <ProtectedRoute>
          <AddCategories />
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
  ]);

  return <RouterProvider router={router} />;
}

export default App;
