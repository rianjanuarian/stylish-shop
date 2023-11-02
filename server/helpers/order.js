const createOrder = () => {
  return `MID-${date.getFullYear()}${date.getMonth()}${date.getDate()}-T${date.getHours()}${date.getMinutes()}${date.getSeconds()}`;
};

module.exports = {
  createOrder,
};
