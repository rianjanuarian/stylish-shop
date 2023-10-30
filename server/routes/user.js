const userRoutes = require("express").Router();
const { verifyUser, verifyAdmin } = require("../middlewares/verifyRole");
const UserControllers = require("../controllers/UserController");

//User Auth
userRoutes.post("/login", UserControllers.login);
// userRoutes.post("/google-sign-in", UserControllers.signInWithGoogle);
userRoutes.post("/register", UserControllers.register);
userRoutes.post("/create_admin", UserControllers.createAdmin);
userRoutes.get("/logout", UserControllers.logout);

//User Data
userRoutes.put("/change_password", verifyUser, UserControllers.changePassword);
userRoutes.put("/update", verifyUser, UserControllers.update);
userRoutes.get("/", verifyAdmin, UserControllers.getUser);
userRoutes.delete("/delete/:id", verifyAdmin, UserControllers.delete);
userRoutes.put("/update/:id", verifyAdmin, UserControllers.updateAdmin);
// userRoutes.get("/", UserControllers.getData);
// userRoutes.post("/create", UserControllers.create);
// userRoutes.put("/update/:id", UserControllers.update);
// userRoutes.delete("/delete/:id", UserControllers.delete);

module.exports = userRoutes;
