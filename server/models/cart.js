"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class cart extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      cart.belongsTo(models.user);
      cart.belongsTo(models.product);
      cart.hasMany(models.transaction);
    }
  }
  cart.init(
    {
      // id: {
      //   allowNull: false,
      //   type: DataTypes.INTEGER,
      //   primaryKey: true,
      // },
      userId: DataTypes.INTEGER,
      productId: DataTypes.INTEGER,
      qty: { type: DataTypes.INTEGER, defaultValue: 1 },
      total_price: DataTypes.INTEGER,
      color: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: "cart",
    }
  );
  return cart;
};
