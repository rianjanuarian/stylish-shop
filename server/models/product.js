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
        foreignKey: "productId",
        otherKey: "categoryId",
        onDelete: "CASCADE",
      });
      product.belongsToMany(models.brand, {
        through: models.brandproduct,
        foreignKey: "productId",
        otherKey: "brandId",
        onDelete: "CASCADE",
      });
      // coba
      product.hasMany(models.cart);
      // product.belongsToMany(models.user, {
      //   through: models.cart,
      // });
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
      image: {
        type: DataTypes.STRING,
        defaultValue:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png",
      },
      colors: { type: DataTypes.ARRAY(DataTypes.STRING), defaultValue: [] },
    },
    {
      sequelize,
      modelName: "product",
    }
  );
  return product;
};
