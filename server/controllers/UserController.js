const { decryptPassword, encryptPassword } = require("../helpers/bcyrpt");
const {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
} = require("../helpers/jsonwebtoken");
const createError = require("../middlewares/createError");
const verifyGoogleOAuthToken = require("../middlewares/googleAuth");
const { user } = require("../models");
const admin = require("firebase-admin");

class UserController {
  static async registerWithEmail(req, res, next) {
    try {
      let { name, email, password } = req.body;
      password = await encryptPassword(password);

      const isEmailExist = await user.findOne({
        where: {
          email,
        },
      });

      if (isEmailExist) {
        return next(
          createError(409, "User with the same email already exists!")
        );
      }

      if (password.length < 8) {
        return next(
          createError(400, "Password must be at least 8 characters!")
        );
      }

      const newUser = await admin.auth().createUser({
        name,
        email,
        password,
      });
      const uid = newUser.uid;

      const response = await user.create({
        name,
        email,
        password,
        uid,
      });

      res.status(201).json({ message: "New user has been created!", response });
    } catch (error) {
      next(error);
    }
  }

  static async registerWithGoogle(req, res, next) {
    try {
      const token = req.headers.access_token;
      decodeTokenUsingJwt(token, (err, user) => {
        if (err) {
          return next(createError(403, "Token is invalid!"));
        }
        req.user = user;
      });

      const { uid, name, email } = req.user;
      const response = await user.create({
        uid,
        name,
        email,
      });

      res.status(201).json({ message: "New user has been created!", response });
    } catch (error) {
      next(error);
    }
  }

  static async loginWithEmail(req, res, next) {
    try {
      const yuser = await user.findOne({
        where: {
          email: req.body.email,
        },
      });

      if (!yuser) {
        next(createError(404, "User not found!"));
      }

      if (!(await decryptPassword(req.body.password, yuser.password))) {
        next(createError(401, "Password is incorrect!"));
      }

      const { password, ...otherDetails } = yuser;

      const access_token = encodeTokenUsingJwt({ ...otherDetails });
      res.setHeader("access_token", access_token);
      res
        .status(200)
        .json({ message: "You are successfully logged in!", access_token });
    } catch (err) {
      next(err);
    }
  }

  static async loginWithGoogle(req, res, next) {
    try {
      const { credentials } = req.body;
      const access_token = encodeTokenUsingJwt(credentials);
      res.setHeader("access_token", access_token);
      res
        .status(200)
        .json({ message: "You are successfully logged in!", access_token });
    } catch (error) {
      next(error);
    }
  }

  static async getUser(req, res, next) {
    try {
      const response = await user.findAll();
      res.status(200).json(response);
    } catch (error) {
      next(error);
    }
  }

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

  static async createAdmin(req, res, next) {
    try {
      const { name, email, password } = req.body;
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

      const response = await user.create({
        name: name,
        email: email,
        role: "admin",
        password: password,
      });

      res.status(201).json({ message: "Admin has been created!", response });
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
          const access_token = encodeTokenUsingJwt(yuser);
          res.setHeader("access_token", access_token);
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

  // updated
  static async changePassword(req, res, next) {
    try {
      const currentPasswords = req.user.password;
      const { oldPassword, newPassword, confirmPassword } = req.body;

      if (newPassword !== confirmPassword) {
        return next(createError(400, "Password not match!"));
      }

      if ((await decryptPassword(oldPassword, currentPasswords)) === false) {
        return next(createError(400, "Old password not match!"));
      }

      const password = await encryptPassword(newPassword);
      await user.update(password, {
        where: {
          uid: req.user.uid,
        },
      });
    } catch (error) {
      next(error);
    }
  }

  // old
  // static async changePassword(req, res, next) {
  //   try {
  //     const passwords = req.user.password;
  //     const { oldPassword, newPassword, confirmPassword } = req.body;
  //     if (await decryptPassword(oldPassword, passwords)) {
  //       if (newPassword === confirmPassword) {
  //         await user.update(
  //           { password: await encryptPassword(newPassword) },
  //           {
  //             where: {
  //               uid: req.user.uid,
  //             },
  //           }
  //         );
  //         res.status(200).json({ message: "Password has been changed!" });
  //       } else {
  //         next(createError(400, "Password not match!"));
  //       }
  //     } else {
  //       next(createError(400, "Old password not match!"));
  //     }
  //   } catch (error) {
  //     next(error);
  //   }
  // }

  //new
  static async update(req, res, next) {
    try {
      const uid = req.user.uid;
      const response = await user.update(req.body, {
        where: {
          uid: uid,
        },
      });

      if (response[0] !== 1) {
        return next(createError(400, "User failed to updated!"));
      }

      res.status(200).json({ message: "User has been updated!" });
    } catch (error) {
      next(error);
    }
  }

  //old
  // static async update(req, res, next) {
  //   try {
  //     const uid = req.user.uid;
  //     const { name, address, gender, image, birthday, phone_number } = req.body;
  //     const response = await user.update(
  //       {
  //         name: name,
  //         address: address,
  //         gender: gender,
  //         image: image,
  //         birthday: birthday,
  //         phone_number: phone_number,
  //       },
  //       {
  //         where: {
  //           uid: uid,
  //         },
  //       }
  //     );
  //     if (response[0] === 1) {
  //       res.status(200).json({ message: "User has been updated!" });
  //     } else {
  //       next(createError(400, "User cannot be updated!"));
  //     }
  //   } catch (error) {
  //     next(error);
  //   }
  // }

  static async updateAdmin(req, res, next) {
    const id = req.params.id;
    try {
      const uid = await user.findOne({
        where: {
          id: req.params.id,
        },
      });
      const { name, email, address, gender, image, birthday, phone_number } =
        req.body;
      const firebaseUID = uid.uid;

      const userRecord = await admin.auth().updateUser(firebaseUID, {
        email: email,
      });

      if (userRecord.email !== email) {
        return next(createError(400, "Email cannot be updated!"));
      }

      const response = await user.update(
        {
          name: name,
          email: email,
          address: address,
          gender: gender,
          image: image,
          birthday: birthday,
          phone_number: phone_number,
        },
        {
          where: {
            id: id,
          },
        }
      );
      if (response[0] === 1) {
        res.status(200).json({ message: "User has been updated!" });
      } else {
        next(createError(400, "User cannot be updated!"));
      }
    } catch (error) {
      next(error);
    }
  }

  static async delete(req, res, next) {
    try {
      const uid = await user.findOne({
        where: {
          id: req.params.id,
        },
      });
      const id = req.params.id;
      await admin.auth().deleteUser(uid.uid);
      const response = await user.destroy({
        where: {
          id: id,
        },
      });
      if (response === 1) {
        res.status(200).json({ message: "User has been deleted!" });
      } else {
        next(createError(400, "User cannot be deleted!"));
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
