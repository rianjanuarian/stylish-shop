
import { getUsers, updateUsers, userSelectors } from "../../redux/userSlice";
import { useDispatch, useSelector } from "react-redux";
import React, { useState, useEffect } from "react";

const UpdateUser = (props) => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [image, setImage] = useState("");
  const [address, setAddress] = useState("");
  const [gender, setGender] = useState("");
  const [birthday, setBirthday] = useState("");
  const [phone_number, setPhone_number] = useState("");

  const dispatch = useDispatch();
 
  const  id  = props.userId
  const user = useSelector((state) => userSelectors.selectById(state, id));
  useEffect(() => {
    dispatch(getUsers());
  }, [dispatch]);

  useEffect(() => {
    if (user) {
      setName(user.name);
      setEmail(user.email);
      setImage(user.image);
      setAddress(user.address);
      setGender(user.gender);
      setBirthday(user.birthday);
      setPhone_number(user.phone_number);
    }
  }, [user]);

  const handleUpdate = async (e) => {
    e.preventDefault();
    await dispatch(
      updateUsers({
        id: id,
        name: name,
        email: email,
        image: image,
        address: address,
        gender: gender,
        birthday: birthday,
        phone_number: phone_number,
      })
    );
    props.toggleModalEdit();
    window.location.href = "/user";
  };
  const handleImageChange = (event) => {
    setImage(event.target.files[0]);
  };
  return (
 <>   <div className="modal">
 <div className="overlay" onClick={props.toggleModalEdit}>
   <div className="modal-content" onClick={(e) => e.stopPropagation()}>
     <h1>Update Admin</h1>
     <form onSubmit={handleUpdate}>
     <label htmlFor="fname">Name</label>
     <input
       type="text"
       value={name}
       onChange={(e) => setName(e.target.value)}
     />
     <label htmlFor="fname">Email</label>
     <input
       type="email"
       value={email}
       onChange={(e) => setEmail(e.target.value)}
     />

     <label htmlFor="fname">Image</label>
     <input type="file" onChange={handleImageChange} />
     <label htmlFor="fname">Address</label>
     <input
       type="text"
       value={address}
       onChange={(e) => setAddress(e.target.value)}
     />
 
     <label htmlFor="gender">Gender</label>
     <select
       id="gender"
       name="gender"
       onChange={(e) => setGender(e.target.value)}
     >
       <option value="" disabled selected>
         --
       </option>
       <option value="man">Male</option>
       <option value="woman">Female</option>
   
     </select>
     <label htmlFor="fname">Birthday</label>
     <input
       type="datetime-local"
       value={birthday}
       onChange={(e) => setBirthday(e.target.value)}
     />
     <label htmlFor="fname">Phone</label>
     <input
       type="text"
       value={phone_number}
       onChange={(e) => setPhone_number(e.target.value)}
     />
     <input type="submit" value="Submit" />
     </form>
   </div>
 </div>
</div>
</>

    // <div className="dashboard-container">
    //   <SideBar menu={sidebar_menu} />
    //   <div className="dashboard-body">
    //     <div className="addform">
    //       <h1>Update User / Admin</h1>
    //       <form onSubmit={handleUpdate}>
    //         <label htmlFor="fname">Name</label>
    //         <input
    //           type="text"
    //           value={name}
    //           onChange={(e) => setName(e.target.value)}
    //         />
    //         <label htmlFor="fname">Email</label>
    //         <input
    //           type="email"
    //           value={email}
    //           onChange={(e) => setEmail(e.target.value)}
    //         />

    //         <label htmlFor="fname">Image</label>
    //         <input type="file" onChange={handleImageChange} />
    //         <label htmlFor="fname">Address</label>
    //         <input
    //           type="text"
    //           value={address}
    //           onChange={(e) => setAddress(e.target.value)}
    //         />
        
    //         <label htmlFor="gender">Gender</label>
    //         <select
    //           id="gender"
    //           name="gender"
    //           onChange={(e) => setGender(e.target.value)}
    //         >
    //           <option value="" disabled selected>
    //             --
    //           </option>
    //           <option value="man">Male</option>
    //           <option value="woman">Female</option>
          
    //         </select>
    //         <label htmlFor="fname">Birthday</label>
    //         <input
    //           type="datetime-local"
    //           value={birthday}
    //           onChange={(e) => setBirthday(e.target.value)}
    //         />
    //         <label htmlFor="fname">Phone</label>
    //         <input
    //           type="text"
    //           value={phone_number}
    //           onChange={(e) => setPhone_number(e.target.value)}
    //         />
    //         <input type="submit" value="Submit" />
    //       </form>
    //     </div>
    //   </div>
    // </div>
  );
};

export default UpdateUser;
