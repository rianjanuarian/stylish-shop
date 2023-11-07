const userRoutes = require("express").Router();
const { verifyUser, verifyAdmin } = require("../middlewares/verifyRole");
const UserControllers = require("../controllers/UserController");
const upload = require("../multerconfig");


 
//User Auth
userRoutes.post("/register_with_email", UserControllers.registerWithEmail);
userRoutes.post("/register_with_google", UserControllers.registerWithGoogle);
userRoutes.post("/login_with_email", UserControllers.loginWithEmail);
userRoutes.post("/login_with_google", UserControllers.loginWithGoogle);
userRoutes.get('/getUser', verifyUser, UserControllers.getOneUser);
userRoutes.get('/logout', UserControllers.logout);

//Admin Only
userRoutes.get("/", verifyAdmin, UserControllers.getUsers);
userRoutes.post("/create_admin",verifyAdmin, upload.single("images"), UserControllers.createAdmin);
userRoutes.post("/login_admin", UserControllers.loginAdmin);
userRoutes.put(
  "/change_password_admin",
  verifyAdmin,
  UserControllers.changePassword
);
userRoutes.put("/update_admin/:id", upload.single("images"), verifyAdmin, UserControllers.updateAdminV2);
userRoutes.delete(
  "/delete_account/:id",
  verifyAdmin,
  UserControllers.deleteAccount
);
userRoutes.get('/get_user_admin', verifyAdmin, UserControllers.getOneUser);

//User Data
userRoutes.put("/change_password", verifyUser, UserControllers.changePassword);
userRoutes.put("/update", verifyUser, UserControllers.update);

module.exports = userRoutes;
