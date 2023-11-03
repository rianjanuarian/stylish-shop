import React from "react";
import {
  updateBrands,
  brandSelectors,
  getBrands,
} from "../../redux/brandSlice";
import { useParams } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";

const ModalEditbrand = (props) => {
  const [name, setName] = useState("");
  const [image, setImage] = useState("");
  const dispatch = useDispatch();
  const { id } = useParams();
  const brand = useSelector((state) => brandSelectors.selectById(state, id));

  useEffect(() => {
    dispatch(getBrands());
  }, [dispatch]);

  useEffect(() => {
    if (brand) {
      setName(brand.name);
      setImage(brand.image);
    }
  }, [brand]);
  const handleUpdate = (e) => {
    e.preventDefault();
    dispatch(updateBrands({ id, name, image }));
    props.setModal();
  };
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };

  return (
    <div className="modal">
      <div className="overlay" onClick={props.toggleModal}>
        <div className="modal-content" onClick={handleInputClick}>
          <h1>Add Brand</h1>
          <form onSubmit={handleUpdate}>
            <label for="fname">Name</label>
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
            />
            <label for="fname">Image</label>
            <input type="file" onChange={handleImageChange} />
            <input type="submit" value="Submit" />
          </form>
        </div>
      </div>
    </div>
  );
};

export default ModalEditbrand;
