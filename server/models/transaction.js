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
    }
  }
  transaction.init(
    {
      cartId: DataTypes.INTEGER,
      courierId: DataTypes.INTEGER,
      midtranstoken: DataTypes.STRING,
      status: {
        type: DataTypes.ENUM("pending", "reject", "approve"),
        defaultValue: "pending",
      },
    },
    {
      sequelize,
      modelName: "transaction",
    }
  );
  return transaction;
};
