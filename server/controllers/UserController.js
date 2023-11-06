const { decryptPassword, encryptPassword } = require("../helpers/bcyrpt");
const {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
} = require("../helpers/jsonwebtoken");
const createError = require("../middlewares/createError");
const { user } = require("../models");
const admin = require("firebase-admin");

class UserController {
  //User Authentication
  static async registerWithEmail(req, res, next) {
    try {
      let { name, email, password } = req.body;

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

      password = await encryptPassword(password);

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
        return next(createError(404, "User not found!"));
      }

      if (!(await decryptPassword(req.body.password, yuser.password))) {
        return next(createError(401, "Password is incorrect!"));
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

  static async logout(req, res, next) {
    delete req.headers["access_token"];
    res.json({ msg: "User has been sign out successfully" });
  }

  //User Data
  static async changePassword(req, res, next) {
    try {
      const currentPasswords = req.user.dataValues.password;
      const { oldPassword, newPassword, confirmPassword } = req.body;

      if (newPassword !== confirmPassword) {
        return next(
          createError(400, "New Password not match with confirm password!")
        );
      }

      if ((await decryptPassword(oldPassword, currentPasswords)) === false) {
        return next(
          createError(400, "Old password does not match the current password!")
        );
      }

      const password = await encryptPassword(newPassword);
      const response = await user.update(
        { password },
        {
          where: {
            uid: req.user.dataValues.uid,
          },
        }
      );

      if (response[0] !== 1) {
        res.json({ message: "Password has not been changed!" });
      }

      res.json({ message: "Password has been changed!" });
    } catch (error) {
      next(error);
    }
  }

  static async update(req, res, next) {
    try {
      const uid = req.user.dataValues.uid;
      const patternPhoneNumber =
        /^(\+62|0|62)[\s.-]?(\d{2,4})[\s.-]?(\d{4})[\s.-]?(\d{4})$/;

      const response = await user.update(req.body, {
        where: {
          uid,
        },
      });

      if (patternPhoneNumber.test(req.body.phone_number) === false) {
        return next(createError(400, "Phone number is not valid!"));
      } // Check phone number format ~Indra Oki Sandy~

      if (response[0] !== 1) {
        return next(createError(400, "User failed to updated!"));
      }

      res.status(200).json({ message: "User has been updated!" });
    } catch (error) {
      next(error);
    }
  }

  //only admin can access part
  static async createAdmin(req, res, next) {
    try {
      let { name, email, password } = req.body;
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

      password = await encryptPassword(password);
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
        role: "admin",
      });

      res
        .status(201)
        .json({ message: "New admin has been created!", response });
    } catch (error) {
      next(error);
    }
  }

  static async loginAdmin(req, res, next) {
    try {
      const yuser = await user.findOne({
        where: {
          email: req.body.email,
        },
      });

      if (!yuser) {
        return next(createError(404, "User not found!"));
      }

      if (!(await decryptPassword(req.body.password, yuser.password))) {
        return next(createError(401, "Password is incorrect!"));
      }

      if (yuser.role !== "admin") {
        return next(
          createError(403, "You must be an admin to access this page!")
        );
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

  static async updateAdminV2(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const adminAccount = await user.findByPk(id);

      if (!adminAccount) {
        return next(createError(404, "User not found!"));
      }

      const response = await adminAccount.update(req.body);

      if (response.dataValues) {
        res.status(200).json({ message: "User has been updated!" });
      }
    } catch (error) {
      next(error);
    }
  }

  static async deleteAccount(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const account = await user.findByPk(id);

      if (!account) {
        return next(createError(404, "User not found!"));
      }

      await admin.auth().deleteUser(account.uid);
      await account.destroy();
      res.status(200).json({ message: "User has been deleted!" });
    } catch (error) {
      next(error);
    }
  }

  static async getUsers(req, res, next) {
    try {
      const response = await user.findAll();
      res.status(200).json(response);
    } catch (error) {
      next(error);
    }
  }

  static async getOneUser(req, res, next) {
    try {
      const id = parseInt(req.user.dataValues.id);
      const currentUser = await user.findByPk(id);

      if (!currentUser) {
        return next(createError(404, "User not found!"));
      }
      res.status(200).json(currentUser);

    } catch (error) {
      next(error);
    }
  }
}

module.exports = UserController;
