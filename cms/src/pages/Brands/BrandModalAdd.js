import React, { useState } from "react";
import { useDispatch } from "react-redux";
import { saveBrand } from "../../redux/brandSlice";
import Swal from "sweetalert2";

const BrandModalAdd = (props) => {
  const dispatch = useDispatch();
  const [name, setName] = useState("");
  const [image, setImage] = useState(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const createNewBrand = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    dispatch(saveBrand({ name, image }))
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
    <>
      <div className="modal">
        <div className="overlay" onClick={props.toggleModalAdd}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <h1>Add Brand</h1>
            <form onSubmit={createNewBrand}>
              <label htmlFor="fname">Name</label>
              <input type="text" onChange={(e) => setName(e.target.value)} />
              <label htmlFor="fname">Image</label>
              <input type="file" onChange={handleImageChange} />
              <input type="submit" value="Submit" disabled={isLoading} />
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default BrandModalAdd;
