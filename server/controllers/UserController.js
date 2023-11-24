const { decryptPassword, encryptPassword } = require("../helpers/bcyrpt");
const {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
} = require("../helpers/jsonwebtoken");
const createError = require("../middlewares/createError");
const { user } = require("../models");
const admin = require("firebase-admin");
const { Storage } = require("@google-cloud/storage");
const storage = new Storage({
  projectId: "7c8c89da30790dc43d65677a33d2b042d6b3e7b3",
  credentials: require("../helpers/cloud-storage.json"),
});
class UserController {
  //User Authentication
  static async registerWithEmail(req, res, next) {
    try {
      let { name, email, password, uid } = req.body;

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

      const { password, ...otherDetails } = yuser.dataValues;

      const access_token = encodeTokenUsingJwt({ ...otherDetails });
      res.setHeader("Authorization", `Bearer ${access_token}`);
      res.status(200).json({
        message: "You are successfully logged in!",
        access_token: access_token,
      });
    } catch (err) {
      next(err);
    }
  }

  static async loginWithGoogle(req, res, next) {
    try {
      const { email, uid } = req.query;

      const isEmailExist = await user.findOne({
        where: {
          email,
        },
      });

      if (isEmailExist) {
        const access_token = encodeTokenUsingJwt(isEmailExist.dataValues);
        return res.status(200).json({
          message: "You are successfully logged in!",
          access_token: access_token,
        });
      }

      const response = await user.create({
        uid,
        email,
        name: req.body.name,
      });

      const access_token = encodeTokenUsingJwt(response.dataValues);
      res.setHeader("Authorization", `Bearer ${access_token}`);
      res.status(200).json({
        message: "You are successfully logged in!",
        access_token: access_token,
      });
    } catch (error) {
      next(error);
    }
  }

  static async logout(req, res, next) {
    delete req.headers["Authorization"];
    res.json({ msg: "User has been sign out successfully" });
  }

  //User Data
  static async changePassword(req, res, next) {
    try {
      const currentUser = await user.findByPk(req.user.id);
      const currentPasswords = currentUser.dataValues.password;

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
      await currentUser.update({ password });
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

      if (patternPhoneNumber.test(req.body.phone_number) === false) {
        return next(createError(400, "Phone number is not valid!"));
      } // Check phone number format ~Indra Oki Sandy~

      const bucketName = "stylish-shop";
      const destination = `users/${req.file.filename}`;

      if (req.file) {
        await storage.bucket(bucketName).upload(req.file.path, {
          destination,
        });
      }

      const image = req.file
        ? `${bucketName}/${destination}`
        : req.user.dataValues.image;

      const response = await user.update(
        { image, ...req.body },
        {
          where: {
            uid,
          },
        }
      );

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

      const bucketName = "stylish-shop";

      const destination = `users/${req.file.filename}`;
      await storage.bucket(bucketName).upload(req.file.path, {
        destination,
      });
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
        image: `${bucketName}/${destination}`,
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

      const { password, createdAt, updatedAt, ...userToSendToFrontend } =
        yuser.dataValues;
      const accessToken = encodeTokenUsingJwt({ ...userToSendToFrontend });
      res.setHeader("Authorization", `Bearer ${accessToken}`);
      res.status(200).json({
        message: "You are successfully logged in!",
        accessToken,
        currentUser: userToSendToFrontend,
      });
    } catch (err) {
      next(err);
    }
  }

  static async updateAdmin(req, res, next) {
    try {
      const id = parseInt(req.params.id);

      const adminAccount = await user.findByPk(id);
      const bucketName = "stylish-shop";

      const destination = `users/${req.file.filename}`;
      if (!adminAccount) {
        return next(createError(404, "User not found!"));
      }
      await storage.bucket(bucketName).upload(req.file.path, {
        destination,
      });
      const image = req.file
        ? `${bucketName}/${destination}`
        : currentProduct.dataValues.image;
      const updatedData = {
        name: req.body.name,
        email: req.body.email,
        image: image,
        address: req.body.address,
        gender: req.body.gender,
        birthday: req.body.birthday,
        phone_number: req.body.phone_number,
      };
      const response = await adminAccount.update(updatedData);

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
      const id = parseInt(req.user.id);
      const currentUser = await user.findByPk(id);

      if (!currentUser) {
        return next(createError(404, "User not found!"));
      }
      const { password, ...otherDetails } = currentUser.dataValues;
      res.status(200).json({ ...otherDetails });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = UserController;
