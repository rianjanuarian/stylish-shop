const createOrder = () => {
  const date = new Date();
  return `MID-${date.getFullYear()}${date.getMonth()}${date.getDate()}-T${date.getHours()}${date.getMinutes()}${date.getSeconds()}`;
};

module.exports = {
  createOrder,
};
