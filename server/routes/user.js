const userRoutes = require("express").Router();
const { verifyUser, verifyAdmin } = require("../middlewares/verifyRole");
const UserControllers = require("../controllers/UserController");

//User Auth
userRoutes.post("/register_with_email", UserControllers.registerWithEmail);
userRoutes.post("/register_with_google", UserControllers.registerWithGoogle);
userRoutes.post("/login_with_email", UserControllers.loginWithEmail);
userRoutes.post("/login_with_google", UserControllers.loginWithGoogle);

//Admin Only
userRoutes.get("/", verifyAdmin, UserControllers.getUser);
userRoutes.post("/login_admin", UserControllers.loginAdmin);
userRoutes.post("/create_admin", verifyAdmin, UserControllers.createAdmin);
userRoutes.put("/update_admin/:id", verifyAdmin, UserControllers.updateAdminV2);
userRoutes.delete("/delete_account/:id", verifyAdmin, UserControllers.deleteAccount);

//User Data
userRoutes.put("/change_password", verifyUser, UserControllers.changePassword);
userRoutes.put("/update", verifyUser, UserControllers.update);

//bisa dibuang
userRoutes.put("/update/:id", verifyAdmin, UserControllers.updateAdmin);userRoutes.post("/register", UserControllers.register);
userRoutes.post("/login", UserControllers.login);
userRoutes.post("/google_sign_in", UserControllers.signInWithGoogle);
userRoutes.get("/logout", UserControllers.logout);


module.exports = userRoutes;
