import React from "react";
import { Routes, Route } from "react-router-dom";
import { LoginPage, Dashboard, Orders, Product, UserList,AddProduct,AddBrand,AddCategories, AddUser } from "../pages";

const MainContent = () => {
  return (
    <>
      <Routes>
        <Route path="/" element={<LoginPage></LoginPage>} />
        <Route exact path="/dashboard" element={<Dashboard></Dashboard>} />
        <Route exact path="/orders" element={<Orders />} />
        <Route exact path="/locations" element={<div></div>} />
        <Route exact path="/profile" element={<div></div>} />
        <Route exact path="/user" element={<UserList></UserList>} />
        <Route exact path="/products" element={<Product></Product>} />
        <Route exact path="/addProduct" element={<AddProduct></AddProduct>} />
        <Route exact path="/addBrand" element={<AddBrand></AddBrand>} />
        <Route exact path="/addCategory" element={<AddCategories></AddCategories>} />
        <Route exact path="/addUser" element={<AddUser></AddUser>} />
      </Routes>
    </>
  );
};

export default MainContent;
