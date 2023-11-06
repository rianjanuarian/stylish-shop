"use strict";
const { Model } = require("sequelize");

module.exports = (sequelize, DataTypes) => {
  class user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      user.hasMany(models.transaction);
      // Coba
      user.hasOne(models.cart);
      // user.belongsToMany(models.product, {
      //   through: models.cart,
      // });
      user.hasMany(models.transaction);
    }
  }
  user.init(
    {
      uid: {
        type: DataTypes.STRING,
        unique: true,
      },
      name: {
        type: DataTypes.STRING,
        validate: {
          notEmpty: {
            msg: "Name cannot be empty",
          },
        },
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notNull: {
            msg: "Email cannot be empty",
          },
          notEmpty: {
            msg: "Email cannot be empty",
          },
          isEmail: {
            msg: "Invalid email format",
          },
        },
      },
      password: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      image: {type: DataTypes.STRING, defaultValue: "http://via.placeholder.com/100"},
      address: DataTypes.STRING,
      role: { type: DataTypes.ENUM("admin", "user"), defaultValue: "user" },
      gender: DataTypes.ENUM("man", "woman"),
      birthday: DataTypes.DATE,
      phone_number: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: "user",
    }
  );
  return user;
};
