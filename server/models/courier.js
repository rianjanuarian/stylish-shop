"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class courier extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      courier.hasMany(models.transaction);
    }
  }
  courier.init(
    {
      name: DataTypes.STRING,
      price: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "courier",
    }
  );
  return courier;
};
