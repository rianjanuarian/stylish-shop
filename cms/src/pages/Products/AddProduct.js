import React from "react";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
const AddProduct = () => {
  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="addform">
          <h1>Add Product</h1>
          <form>
            <label for="fname">Name</label>
            <input type="text" id="fname" name="firstname" />

            <label for="fname">Price</label>
            <input type="number" id="lname" name="lastname" />

            <label for="fname">Category</label>
            <select id="country" name="country">
              <option value="australia">Shoes</option>
              <option value="canada">Shirt</option>
              <option value="usa">Jewelry</option>
            </select>
            <label for="fname">Brand</label>
            <select id="country" name="country">
              <option value="australia">Adidas</option>
              <option value="canada">Uniqlo</option>
              <option value="usa">Prestige</option>
            </select>

            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default AddProduct;
