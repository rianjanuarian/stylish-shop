"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class brandproduct extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      brandproduct.belongsTo(models.brand);
      brandproduct.belongsTo(models.product);
    }
  }
  brandproduct.init(
    {
      productId: DataTypes.INTEGER,
      brandId: DataTypes.INTEGER,
    },
    {
      sequelize,
      modelName: "brandproduct",
    }
  );
  return brandproduct;
};
