const { decodeTokenUsingJwt } = require("../helpers/jsonwebtoken");
const createError = require("./createError");

const verifyToken = (req, res, next) => {
  const token = req.headers.access_token;

  if (!token) {
    return next(createError(401, "You must be logged in to access this!"));
  }

  decodeTokenUsingJwt(token, (err, user) => {
    if (err) {
      return next(createError(403, "Token is invalid!"));
    }
    req.user = user;
    next();
  });
};

const verifyUser = (req, res, next) => {
  verifyToken(req, res, (err) => {
    if (err) {
      return next(err);
    }
    if (req.user.role !== "user") {
      return next(
        createError(403, "You do not have permisson to access this!")
      );
    }
    next();
  });
};

const verifyAdmin = (req, res, next) => {
  verifyToken(req, res, (err) => {
    if (err) {
      return next(err);
    }
    if (req.user.role !== "admin") {
      return next(
        createError(403, "You do not have permisson to access this!")
      );
    }
    next();
  });
};

module.exports = {
  verifyUser,
  verifyAdmin,
};
