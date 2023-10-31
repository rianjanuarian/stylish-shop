import React from "react";
import { Routes, Route } from "react-router-dom";
import { LoginPage, Dashboard, Orders, Product, UserList } from "../pages";

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
      </Routes>
    </>
  );
};

export default MainContent;
