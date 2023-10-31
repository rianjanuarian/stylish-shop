const userRoutes = require("express").Router();
const { verifyUser, verifyAdmin } = require("../middlewares/verifyRole");
const UserControllers = require("../controllers/UserController");

//User Auth
userRoutes.post("/register_with_email", UserControllers.registerWithEmail);
userRoutes.post("/register_with_google", UserControllers.registerWithGoogle);
userRoutes.post("/login_with_email", UserControllers.loginWithEmail);
userRoutes.post("/login_with_google", UserControllers.loginWithGoogle);

userRoutes.post("/register", UserControllers.register);
userRoutes.post("/login", UserControllers.login);
userRoutes.post("/google_sign_in", UserControllers.signInWithGoogle);
userRoutes.post("/create_admin", UserControllers.createAdmin);
userRoutes.get("/logout", UserControllers.logout);

//User Data
userRoutes.put("/change_password", verifyUser, UserControllers.changePassword);
userRoutes.put("/update", verifyUser, UserControllers.update);
userRoutes.get("/", verifyAdmin, UserControllers.getUser);
userRoutes.delete("/delete/:id", verifyAdmin, UserControllers.delete);
userRoutes.put("/update/:id", verifyAdmin, UserControllers.updateAdmin);

module.exports = userRoutes;
