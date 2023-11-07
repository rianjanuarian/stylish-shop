import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { createCourier } from "../../redux/courierSlice";
import Swal from "sweetalert2";

const CourierModalAdd = (props) => {
  const dispatch = useDispatch();
  const [name, setName] = useState("");
  const [price, setPrice] = useState(0);
  const [image, setImage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const createNewCourier = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    dispatch(createCourier({ name, price, image }))
      .unwrap()
      .then((data) => {
        setIsLoading(false);
        props.toggleModalAdd();
        Swal.fire({
          icon: "success",
          title: data.message,
          showConfirmButton: false,
          timer: 1500,
        });
      })
      .catch((err) => {
        setIsLoading(false);
        Swal.fire({
          icon: "error",
          title: "Error",
          text: err.message,
          footer: err.stack,
        });
      });
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModalAdd}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Add Courier</h1>
          <form onSubmit={createNewCourier}>
            <label htmlFor="fname">Name</label>
            <input type="text" onChange={(e) => setName(e.target.value)} />
            <label htmlFor="fprice">Price</label>
            <input type="number" onChange={(e) => setPrice(e.target.value)} />
            <label htmlFor="fname">Image</label>
            <input type="file" onChange={handleImageChange} />
            <input type="submit" value="Submit" disabled={isLoading} />
          </form>
        </div>
      </div>
    </div>
  );
};

export default CourierModalAdd;
