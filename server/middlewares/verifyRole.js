const { decodeTokenUsingJwt } = require("../helpers/jsonwebtoken");
const createError = require("./createError");

const verifyToken = (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return next(createError(401, "You must be logged in to access this!"));
  }

  if (!authHeader.startsWith('Bearer ')) {
    return next(createError(401, "Invalid token format"));
  }

  const token = authHeader.slice(7);

  decodeTokenUsingJwt(token, (err, user) => {
    if (err) {
      return next(createError(403, err));
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
    if (req.user.dataValues.role !== "user") {
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

    if (req.user.dataValues.role !== "admin") {
      return next(
        createError(403, "You do not have permisson to access this!")
      );
    }
    next();
  });
};

module.exports = {
  verifyToken,
  verifyUser,
  verifyAdmin,
};
