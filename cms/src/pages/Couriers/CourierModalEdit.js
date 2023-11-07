import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { selectCourierById, updateCourier } from "../../redux/courierSlice";
import Swal from "sweetalert2";

const CourierModalEdit = (props) => {
  const id = props.courierId;
  const courier = useSelector((state) => selectCourierById(state, id));
  const dispatch = useDispatch();
  
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [image, setImage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (courier) {
      setName(courier.name);
      setPrice(courier.price);
      setImage(courier.image);
    }
  }, [courier]);

  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(updateCourier({ id, name, price, image })).unwrap()
    .then((data) => {
      setIsLoading(false);
      props.toggleModalEdit();
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
      <div className="overlay" onClick={props.toggleModalEdit}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Edit Courier</h1>
          <form onSubmit={handleUpdate}>
            <label htmlFor="fname">Name</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
            />
            <label htmlFor="fname">Price</label>
            <input
              type="text"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
            />
            <label htmlFor="fname">Image</label>
            <input type="file" onChange={handleImageChange} />
            <input type="submit" value="Submit" disabled={isLoading}/>
          </form>
        </div>
      </div>
    </div>
  );
};

export default CourierModalEdit;
