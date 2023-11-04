import React, { useState } from "react";
import { createBrand } from "../../redux/brandSliceTest";
import { useDispatch } from "react-redux";
import Swal from "sweetalert2";

const ModalAddBrand = (props) => {
  const dispatch = useDispatch();
  const [name, setName] = useState("");
  const [image, setImage] = useState(null);
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const createAddBrand = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append("images", image);
    formData.append("name", name);
    dispatch(createBrand(formData));
    Swal.fire({
      icon: "success",
      title: "Brand has been created!",
      showConfirmButton: false,
      timer: 1500,
    }).then(() => {
      props.toggleModalAdd();
    });
  };

  const handleInputClick = (e) => {
    e.stopPropagation();
  };

  return (
    <>
      <div className="modal">
        <div className="overlay" onClick={props.toggleModalAdd}>
          <div className="modal-content" onClick={handleInputClick}>
            <h1>Add Brand</h1>
            <form onSubmit={createAddBrand}>
              <label htmlFor="fname">Name</label>
              <input type="text" onChange={(e) => setName(e.target.value)} />
              <label htmlFor="fname">Image</label>
              <input type="file" onChange={handleImageChange} />
              <input type="submit" value="Submit" />
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default ModalAddBrand;
