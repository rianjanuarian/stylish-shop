const jwt = require("jsonwebtoken");
const PRIVATE_KEY = 'pejantan';

const encodeTokenUsingJwt = async (token) => {
  try {
    return jwt.sign(token.toJSON(), PRIVATE_KEY, { expiresIn: "1h" });
  } catch (error) {
    throw error;
  }
};

const decodeTokenUsingJwt = async (token, cb) => {
  try {
    return jwt.verify(token, PRIVATE_KEY, cb);
  } catch (error) {
    throw error;
  }
};

module.exports = {
  encodeTokenUsingJwt,
  decodeTokenUsingJwt,
};
