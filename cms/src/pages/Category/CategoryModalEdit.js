import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import Swal from "sweetalert2";
import { selectCategoryById, updateCategory } from "../../redux/categorySlice";

const CategoryModalEdit = (props) => {
  const id = props.categoryId;
  const category = useSelector((state) => selectCategoryById(state, id));
  const dispatch = useDispatch();

  const [name, setName] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    if (category) {
      setName(category.name);
    }
  }, [category]);

  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(updateCategory({ id, name }))
      .unwrap()
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
        setName("");
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
        <div className="overlay" onClick={props.toggleModalEdit}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <h1>Add Category</h1>
            <form onSubmit={handleUpdate}>
              <label htmlFor="fname">Name</label>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
              <input type="submit" value="Submit" disabled={isLoading} />
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default CategoryModalEdit;
