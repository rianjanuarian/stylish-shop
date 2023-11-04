import React, { useState, useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getOneBrand, updateBrand } from "../../redux/brandSliceTest";

const ModalEditbrand = (props) => {
  const id = props.brandId;
  const dispatch = useDispatch();
  const brand = useSelector((state) => state.brandTest.brand);

  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  const [name, setName] = useState("");
  const [image, setImage] = useState("");

  useEffect(() => {
    dispatch(getOneBrand(id));
  }, [dispatch, id]);

  useEffect(() => {
    if (brand) {
      setName(brand.name);
      setImage(brand.image);
    }
  }, [brand]);

  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(updateBrand({ id, name, image }));
    props.toggleModalEdit();
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModalEdit}>
        <div className="modal-content" onClick={(e) => e.stopPropagation()}>
          <h1>Edit Brand</h1>
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
  );
};

export default ModalEditbrand;
