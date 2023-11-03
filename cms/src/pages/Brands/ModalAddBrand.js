import React, { useState } from "react";
import { saveBrands } from "../../redux/brandSlice";
import { useDispatch } from "react-redux";

const ModalAddBrand = (props) => {
  const dispatch = useDispatch();
  const [name, setName] = useState("");
  const [image, setImage] = useState(null);
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const createBrand = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append("images", image);
    formData.append("name", name);
    dispatch(saveBrands(formData));
    props.toggleModal();
  };

  const handleInputClick = (e) => {
    e.stopPropagation();
  };

  return (
    <>
      <div className="modal">
        <div className="overlay" onClick={props.toggleModal}>
          <div className="modal-content" onClick={handleInputClick}>
            <h1>Add Brand</h1>
            <form onSubmit={createBrand}>
              <label for="fname">Name</label>
              <input type="text" onChange={(e) => setName(e.target.value)} />
              <label for="fname">Image</label>
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
