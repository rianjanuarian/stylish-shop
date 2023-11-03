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
  EditBrand,
  EditCategory,
  EditProduct,
} from "./pages";
import { createBrowserRouter, RouterProvider } from "react-router-dom";

const router = createBrowserRouter([
  {
    path: "/",
    element: <LoginPage />,
  },
  {
    path: "/dashboard",
    element: <Dashboard />,
  },
  {
    path: "/orders",
    element: <Orders />,
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
    element: <Product />,
  },
  {
    path: "/addProduct",
    element: <AddProduct />,
  },
  {
    path: "/addBrand",
    element: <AddBrand />,
  },
  {
    path: "/addCategory",
    element: <AddCategories />,
  },
  {
    path: "/addUser",
    element: <AddUser />,
  },
  {
    path: "/brands",
    element: <Brand />,
  },
  {
    path: "/categories",
    element: <Category />,
  },
  {
    path: "/categories/:id",
    element: <Category />,
  },
  {
    path: "/editBrand/:id",
    element: <EditBrand />,
  },
  {
    path: "/editCategory/:id",
    element: <EditCategory />,
  },
  {
    path: "/editProduct/:id",
    element: <EditProduct />,
  },
]);

const App = () => {
  return <RouterProvider router={router} />;
};

export default App;
