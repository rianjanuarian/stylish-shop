"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class History extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  History.init(
    {
      userId: DataTypes.INTEGER,
      status: {
        type: DataTypes.ENUM("pending", "reject", "approve"),
        defaultValue: "pending",
      },
      productId: DataTypes.INTEGER,
      qty: DataTypes.INTEGER,
      variant: DataTypes.STRING,
      orderId: DataTypes.STRING,
      midtransToken: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: "History",
    }
  );
  return History;
};
