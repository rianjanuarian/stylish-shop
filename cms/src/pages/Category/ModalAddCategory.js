import React, { useState } from "react";
import { useDispatch } from "react-redux";
import { createCategory } from "../../redux/categorySliceTest";
import Swal from "sweetalert2";

const ModalAddCategory = (props) => {
  const [name, setName] = useState("");
  const dispatch = useDispatch();

  const addCategory = async (e) => {
    e.preventDefault();
    dispatch(createCategory({ name }));
    Swal.fire({
      icon: "success",
      title: "Category has been created!",
      showConfirmButton: false,
      timer: 1500,
    }).then(() => {
      props.toggleModalAdd();
    });
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModalAdd}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Add Categories</h1>
          <form onSubmit={addCategory}>
            <label htmlFor="fname">Name</label>
            <input
              type="text"
              onChange={(e) => setName(e.target.value)}
              name="firstname"
            />
            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default ModalAddCategory;
