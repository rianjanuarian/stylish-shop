const userRoutes = require("express").Router();
const { verifyUser } = require("../middlewares/verifyRole");
const UserControllers = require("../controllers/UserController");

//User Auth
userRoutes.post("/login", UserControllers.login);
// userRoutes.post("/google-sign-in", UserControllers.signInWithGoogle);
userRoutes.post("/register", UserControllers.register);
userRoutes.get("/logout", UserControllers.logout);

//User Data
userRoutes.put("/change_password", verifyUser, UserControllers.changePassword);
// userRoutes.get("/", UserControllers.getData);
// userRoutes.post("/create", UserControllers.create);
// userRoutes.put("/update/:id", UserControllers.update);
// userRoutes.delete("/delete/:id", UserControllers.delete);

module.exports = userRoutes;
