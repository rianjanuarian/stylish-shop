const { decryptPassword, encryptPassword } = require("../helpers/bcyrpt");
const {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
} = require("../helpers/jsonwebtoken");
const createError = require("../middlewares/createError");
const { user } = require("../models");
const admin = require("firebase-admin");
const { Storage } = require('@google-cloud/storage');
const storage = new Storage({
  projectId: '7c8c89da30790dc43d65677a33d2b042d6b3e7b3',
  credentials: {
    "type": "service_account",
    "project_id": "eastern-dream-272111",
    "private_key_id": "7c8c89da30790dc43d65677a33d2b042d6b3e7b3",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCYjGhb4OdDgM5g\nJSToOdUyJ5OQqgjYKtoGXMHjGkHh/9NEd0EzoIRcx/E8rE4lFxHIt3yIbRq9WbS7\nyv+GShmCBd95cPrqnblT5tfQu7XZiqPWqnGRNQyWcG4EV80DdgpO0muLkkPaP2Su\n/q0HdstQVtX47J3xlqrvQhuf4Rm863pvH/tRTKcsHPS5jXtIX4Vc0qPGp0kwNxUz\n5PMuX2QaJtDN7G9l1Orvr/88CLzuyEYMsYC1O4Nm2tgOPg25MT3UZUxkZFPC73Fz\nHvQOOpffKNzPfI97wdRAZQ+XehJ1JstInhJ5oP3cgvFhu5MQ9k8JX2w2nZVEBJPM\n40ndIxL3AgMBAAECggEADxLwzQNwVs9HlWCWQQxV8NrQTh8/OH0jhjVsQ1C46egp\nrD5Mhxl5euGXCPPN1QRukXLwL1r4pXVT0qrAjTiNRLfn2Uw8vypOweexs8KYuaJl\nhjTZfAvN7p+1f2BdtdXYNum8DtKpOcvB2zj3SCGI/atXAX4ALXtB8NqLeET6Ehzb\nlHoEbsq/oUKD9jf1oKod5kdJ2ciQ/ac49ciBScg53rFx9B4/BwFT0k4Yp2rHBFkh\nzjgx8rU71uXLA9PCaufUkZ6p149sbOm7EdVdMBDRZV2waJvxW6vL/WLp7ooftLdC\nRNxa9kFxtRTywPHA+136slQA729IhUPJeY4UPOrjgQKBgQDVcbZKLL0p11HKCf2K\nLAMygm/xgZFVHbgiXfkAHxv8n2ywtrDHEQegBl2pSVN/4D17HWxSipw/4EmO1+kM\nA/eDlda22SWSmzw8SSWKbjIcdVYayvjF95IJBBa9BuE2pvXDFvDGy0OWSwNvZzCb\nfjr8LCdkM7ifcaGxaNbj3vw+ZwKBgQC29ozq01Fo7uDH/QuZfIJUay24ZO5QK3iF\nN5VVy69qXkrIHOrkDVEODIHQRmCL/pDf1RnZI9ru7M7gyZelQlcAPDcp7s/pTgnc\nAA4B1yN2lVfTovB/X0xtbBorSwVmXc64Vmpqul245sd1unu2EPRTApZNIgksCT4X\nd4PeNJSM8QKBgDzLrduE0MCZNw+wNspjbOm3I4GLoUS4OVl4oNL7CXK0SjYvYzzg\nSea3yXfNjf4PdhOaNt9v4b+D+A+6ygOFIbwWMtlUEpKmqsqVHx9F8foPJd5tz9w7\nfxoYUw22ZvG1Lq1J3H0TKoYlia3ym3K+yrhHL1UoMj8gE6k/rm2rdvejAoGAFDCg\n3Ej1ct7pbyg9X3Kd7zLkmLSKl840Pn8ju5P+h35gQjTutrvBdgtrR9B8VvaAhjK9\n53hNcJAxRBz63wGzGBONAtOXnec+r0hSQ2G6SBuy1WfloiiiBnEnch+VOPahGTZw\nB9cJAJ525Ebv3+d/Dqn6bAiVeoaKk4xcwOiMfAECgYEAjjGx7wnAmo+Dq2vmYCKL\n+Ls0xDQVB91EGkcB+jrg18dgjkCwmbfikL2zLyy4GMbc8NvrBXjPQF7jgvh4WIPo\niB+Jd3Iz2OHzUUjwitSlwKouHBi+sSz42FjS0BuBqLRJgqwnINcqeSUTA2CGANIV\nT3ut7QRUWnML5MEfpThILrk=\n-----END PRIVATE KEY-----\n",
    "client_email": "rianjanuarian@eastern-dream-272111.iam.gserviceaccount.com",
    "client_id": "115909661453997430090",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/rianjanuarian%40eastern-dream-272111.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
});
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

      const { password, ...otherDetails } = yuser.dataValues;

      const access_token = encodeTokenUsingJwt({ ...otherDetails });
      res.setHeader("Authorization", `Bearer ${access_token}`);
      res
        .status(200)
        .json({
          message: "You are successfully logged in!",
          access_token: access_token,
        });
    } catch (err) {
      next(err);
    }
  }

  static async loginWithGoogle(req, res, next) {
    try {
      const { credentials } = req.body;
      const access_token = encodeTokenUsingJwt(credentials);
      res.setHeader("Authorization", `Bearer ${access_token}`);
      res
        .status(200)
        .json({ message: "You are successfully logged in!", access_token });
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
        image: req.file.filename,
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

  static async updateAdminV2(req, res, next) {
    try {
      
      const id = parseInt(req.params.id);

      const adminAccount = await user.findByPk(id);
   const bucketName = 'stylish-shop';

    const destination = `users/${req.file.filename}`;
      if (!adminAccount) {
        return next(createError(404, "User not found!"));
      }
        await storage.bucket(bucketName).upload(req.file.path, {
      destination,
    });
      const updatedData = {
        name: req.body.name,
        email: req.body.email,
        image: `${bucketName}/${destination}`,
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
