const { decryptPassword, encryptPassword } = require("../helpers/bcyrpt");
const {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
} = require("../helpers/jsonwebtoken");
const createError = require("../middlewares/createError");
const { user } = require("../models");
const admin = require("firebase-admin");

class UserController {
  static async register(req, res, next) {
    try {
      const { name, email, password } = req.body;
      const pattern = /^(?=\S{8,}$)/;
      const isEmailExist = await user.findOne({
        where: {
          email: email,
        },
      });

      if (isEmailExist) {
        return next(
          createError(409, "User with the same email already exists!")
        );
      }

      if (!pattern.test(password)) {
        return next(
          createError(400, "Password must be at least 8 characters!")
        );
      }

      const userRecord = await admin.auth().createUser({
        email: email,
        password: password,
      });

      const firebaseUID = userRecord.uid;
      const response = await user.create({
        name: name,
        email: email,
        password: password,
        uid: firebaseUID,
      });

      res.status(201).json({ message: "User has been created!", response });
    } catch (error) {
      next(error);
    }
  }

  static async login(req, res, next) {
    try {
      const yuser = await user.findOne({
        where: {
          email: req.body.email,
        },
      });
      if (yuser) {
        if (await decryptPassword(req.body.password, yuser.password)) {
          const access_token = await encodeTokenUsingJwt(yuser);
          // res.setHeader("access_token", access_token);
          res.status(200).json({ message: "User signed in!", access_token });
        } else {
          next(createError(401, "Password is incorrect!"));
        }
      } else {
        next(createError(404, "User not found!"));
      }
    } catch (err) {
      next(err);
    }
  }

  // static async signInWithGoogle(req, res, next) {
  //   try {
  //     const { idToken } = req.body;

  //     const decodedToken = await admin.auth().verifyIdToken(idToken);
  //     const { uid } = decodedToken;

  //     // Check if the user already exists in your PostgreSQL database
  //     const existingUser = await user.findOne({
  //       where: {
  //         uid: uid,
  //       },
  //     });

  //     if (!existingUser) {
  //       // User doesn't exist in the database; you can create a new user entry or handle as needed.
  //       // For example, you might want to store additional user information.

  //       // Create a new user entry in your database and associate it with the Firebase UID.
  //       const newUser = await user.create({
  //         uid: uid,
  //         // Other user data if needed
  //       });

  //       // Return the new user's data or access token.
  //       res
  //         .status(201)
  //         .json({ message: "User has been created!", user: newUser });
  //     } else {
  //       // Return existing user data or access token.
  //       const access_token = await encodeTokenUsingJwt(existingUser);
  //       res.status(200).json({ message: "User signed in!", access_token });
  //     }
  //   } catch (error) {
  //     next(error);
  //   }
  // }

  static async changePassword(req, res, next) {
    try {
      // DecodeToken
      const access_token = req.headers.access_token;
      const decodeToken = await decodeTokenUsingJwt(access_token);
      const yuser = decodeToken;
      // End DecodeToken
      const { oldPassword, newPassword, confirmPassword } = req.body;
      if (await decryptPassword(oldPassword, yuser.password)) {
        if (newPassword === confirmPassword) {
          await user.update(
            { password: await encryptPassword(newPassword) },
            {
              where: {
                uid: yuser.uid,
              },
            }
          );
          next(createError(200, "Password has been changed!"));
        } else {
          next(createError(400, "Password not match!"));
        }
      } else {
        next(createError(400, "Old password not match!"));
      }
    } catch (error) {
      next(error);
    }
  }

  static async logout(req, res, next) {
    delete req.headers["access_token"];
    res.json({ msg: "dah out" });
  }
}

module.exports = UserController;
