import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { selectBrandById, updateBrand } from "../../redux/brandSlice";
import Swal from "sweetalert2";

const BrandModalEdit = (props) => {
  const id = props.brandId;
  const brand = useSelector((state) => selectBrandById(state, id));
  const dispatch = useDispatch();
  const [name, setName] = useState("");
  const [image, setImage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  useEffect(() => {
    if (brand) {
      setName(brand.name);
      setImage(brand.image);
    }
  }, [brand]);

  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(updateBrand({ id, name, image })).unwrap()
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
    <>
      <div className="modal">
        <div className="overlay" onClick={props.toggleModalAdd}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <h1>Add Brand</h1>
            <form onSubmit={handleUpdate}>
              <label htmlFor="fname">Name</label>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
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

export default BrandModalEdit;
