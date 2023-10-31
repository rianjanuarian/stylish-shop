"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class brand extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here

      brand.belongsToMany(models.product, { through: models.brandproduct });
    }
  }
  brand.init(
    {
      name: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Name cannot be empty",
          },
        },
      },
      image: {
        type: DataTypes.STRING,
        defaultValue: "via.placeholder.com/200",
      },
    },
    {
      sequelize,
      modelName: "brand",
    }
  );
  return brand;
};
