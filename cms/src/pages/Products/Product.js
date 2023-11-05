import React, { useEffect } from "react";
import DashboardHeader from "../../components/DashboardHeader";
import { useSelector, useDispatch } from "react-redux";
import { Link } from "react-router-dom";
import Swal from "sweetalert2";
import sidebar_menu from "../../constants/sidebar-menu";
import SideBar from "../../components/Sidebar/Sidebar";
import "../styles.css";
import empty from "../../assets/images/empty.png";

import {
  productSelectors,
  getProducts,
  deleteProducts,
} from "../../redux/productSlice";

const Product = () => {
  const products = useSelector(productSelectors.selectAll);

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(getProducts());
  }, [dispatch]);

  const deletes = (id) => {
    Swal.fire({
      title: "Are you sure?",
      text: "You won't be able to revert this!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#3085d6",
      cancelButtonColor: "#d33",
      confirmButtonText: "Yes, delete it!",
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire("Deleted!", "Your product has been deleted.", "success");
        dispatch(deleteProducts(id));
      }
    });
  };

  return (
    <div className="dashboard-container">
      <SideBar menu={sidebar_menu} />
      <div className="dashboard-body">
        <div className="dashboard-content">
          <DashboardHeader />
          <div className="dashboard-content-container">
            <div className="dashboard-content-header">
              <h2>Product List</h2>
              <Link to={"/addProduct"} className="rows-btn" type="button">
                Add Product
              </Link>
            </div>
            {products.length !== 0 ? (
              <table>
                <thead>
                  <th>No.</th>
                  <th>NAME</th>
                  <th>PRICE</th>
                  <th>DESCRIPTION</th>
                  <th>STOCK</th>
                  <th>IMAGE</th>
                  <th>COLOR</th>
                  <th>CATEGORIES</th>
                  <th>BRAND</th>
                  <th>ACTION</th>
                </thead>

                <tbody>
                  {products.map((e, index) => (
                    <tr key={e.id}>
                      <td>
                        <span>{index + 1}</span>
                      </td>
                      <td>
                        <span>{e.name}</span>
                      </td>
                      <td>
                        <span>${e.price}</span>
                      </td>
                      <td>
                        <span>{e.description}</span>
                      </td>
                      <td>
                        <span>{e.stock}</span>
                      </td>
                      <td>
                        <span>
                          <img
                            src={`http://localhost:3000/uploads/${e.image}`}
                            style={{ width: "200px", height: "200px" }}
                            alt="Product"
                          ></img>
                        </span>
                      </td>
                      <td>
                        {e.color === null ? (
                          <span>No color</span>
                        ) : (
                          <span>{e.color}</span>
                        )}
                      </td>
                      <td>
                        {e.categories.map((el) => (
                          <span>{el.name}</span>
                        ))}
                      </td>
                      <td>
                        {e.brands.map((el) => (
                          <span>{el.name}</span>
                        ))}
                      </td>
                      <td>
                        <div>
                          <button
                            onClick={() => deletes(e.id)}
                            className="action-btn-delete"
                          >
                            Delete
                          </button>
                          <Link to={`/editProduct/${e.id}`}>
                            <button className="action-btn-update">
                              Update
                            </button>
                          </Link>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            ) : (
              <div className="empty">
                <img src={empty} alt="" />
                <h1>The table is empty! Try adding some!</h1>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Product;
