"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class transaction extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      transaction.belongsTo(models.courier);
      transaction.belongsTo(models.cart);
      transaction.belongsTo(models.user);
    }
  }
  transaction.init(
    {
      userId: DataTypes.INTEGER,
      cartId: DataTypes.STRING,
      courierId: DataTypes.INTEGER,
      orderId: DataTypes.STRING,
      midtranstoken: DataTypes.STRING,
      status: DataTypes.ENUM("pending", "reject", "approve"),
    },
    {
      sequelize,
      modelName: "transaction",
    }
  );
  return transaction;
};
