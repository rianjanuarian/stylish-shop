const { decryptPassword } = require("../helpers/bcyrpt");
const { encodeTokenUsingJwt } = require("../helpers/jsonwebtoken");
const createError = require("../middlewares/createError");
const { user } = require("../models");

class UserController {
  static async register(req, res, next) {
    try {
      const isEmailExist = await user.findOne({
        where: {
          email: req.body.email,
        },
      });

      if (isEmailExist) {
        return next(
          createError(409, "User with the same email already exists!")
        );
      }

      const response = await user.create(req.body);

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
          res.setHeader("access_token", `${access_token}`);
          res.status(200).json(yuser);
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

  static async logout(req, res, next) {
    delete req.headers["access_token"];
    res.json({ msg: "dah out" });
  }
}

module.exports = UserController;
