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
      name: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Name is required",
          },
        },
      },
      price: {
        type: DataTypes.INTEGER,
        validate: {
          notEmpty: {
            msg: "Price is required",
          },
        },
      },
      image: {
        type: DataTypes.STRING,
        defaultValue: "http://via.placeholder.com/100"
      },
    },
    {
      sequelize,
      modelName: "courier",
    }
  );
  return courier;
};
