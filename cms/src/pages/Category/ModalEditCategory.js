import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getOneCategory, updateCategory } from "../../redux/categorySliceTest";

const ModalEditCategory = (props) => {
  const id = props.categoryId;
  const [name, setName] = useState("");
  const dispatch = useDispatch();
  const category = useSelector((state) => state.categoryTest.category);

  useEffect(() => {
    dispatch(getOneCategory(id));
  }, [dispatch, id]);

  useEffect(() => {
    if (category) {
      setName(category.name);
    }
  }, [category]);

  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(updateCategory({ id, name }));
    props.toggleModalEdit();
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModalEdit}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Edit Category</h1>
          <form onSubmit={handleUpdate}>
            <label htmlFor="fname">Name</label>
            <input
              type="text"
              value={name}
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

export default ModalEditCategory;
