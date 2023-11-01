const jwt = require("jsonwebtoken");
const PRIVATE_KEY = process.env.PRIVATE_KEY || "pejantan";

const encodeTokenUsingJwt = (token) => {
  return jwt.sign(token, PRIVATE_KEY);
};

const decodeTokenUsingJwt = (token, cb) => {
  return jwt.verify(token, PRIVATE_KEY, cb);
};

module.exports = {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
};
