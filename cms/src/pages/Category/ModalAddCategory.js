import React, { useState } from "react";
import { useDispatch } from "react-redux";
import { saveCategories } from "../../redux/categorySlice";

const ModalAddCategory = (props) => {
  const [name, setName] = useState("");
  const dispatch = useDispatch();

  const createCategory = async (e) => {
    e.preventDefault();
    await dispatch(saveCategories({ name: name }));
    props.toggleModal();
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModal}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Add Categories</h1>
          <form onSubmit={createCategory}>
            <label for="fname">Name</label>
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
