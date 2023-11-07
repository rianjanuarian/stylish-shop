import React, { useState } from "react";
import { useDispatch } from "react-redux";
import Swal from "sweetalert2";
import { saveCategory } from "../../redux/categorySlice";

const CategoryModalAdd = (props) => {
  const dispatch = useDispatch();
  const [name, setName] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const createNewCategory = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    dispatch(saveCategory({ name }))
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
            <h1>Add Category</h1>
            <form onSubmit={createNewCategory}>
              <label htmlFor="fname">Name</label>
              <input type="text" onChange={(e) => setName(e.target.value)} />
              <input type="submit" value="Submit" disabled={isLoading} />
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default CategoryModalAdd;
