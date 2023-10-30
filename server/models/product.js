"use strict";
const { Model } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
  class product extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here

      product.belongsToMany(models.category, {
        through: models.categoryproduct,
      });
      product.belongsToMany(models.brand, { through: models.brandproduct });
      product.belongsToMany(models.user, {
        through: models.cart,
      });
    }
  }
  product.init(
    {
      name: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Product name cannot be empty",
          },
        },
      },
      price: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Product price cannot be empty",
          },
        },
      },
      description: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Product description cannot be empty",
          },
        },
      },
      stock: {
        type: DataTypes.INTEGER,
        validate: {
          notEmpty: {
            msg: "Product stock cannot be empty",
          },
        },
      },
      image: DataTypes.STRING,
      color: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Product color cannot be empty",
          },
        },
      },
    },
    {
      hooks: {
        beforeCreate: (product, options) => {
          product.image =
            product.image ||
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png";
        },
      },
      sequelize,
      modelName: "product",
    }
  );
  return product;
};
