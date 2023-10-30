"use strict";
const { Model } = require("sequelize");
const { encryptPassword } = require("../helpers/bcyrpt");
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
      user.belongsToMany(models.product, {
        through: models.cart,
      });

      
    }
  }
  user.init(
    {
      uid: {
        type: DataTypes.STRING,
        unique: true,
      },
      name: DataTypes.STRING,
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
        allowNull: false,
        validate: {
          notNull: {
            msg: "Password cannot be empty",
          },
          notEmpty: {
            msg: "Password cannot be empty",
          },
          isAtLeastEightCharacters(value) {
            if (value.length < 8) {
              throw new Error("Password must be at least 8 characters long");
            }
          },
        },
      },
      image: DataTypes.STRING,
      address: DataTypes.STRING,
      role: DataTypes.ENUM("admin", "user"),
      gender: DataTypes.ENUM("man", "woman"),
      birthday: DataTypes.DATE,
      phone_number: DataTypes.STRING,
    },
    {
      hooks: {
        beforeCreate: async (user, options) => {
          user.password = await encryptPassword(user.password);
          user.role = user.role || "user";
        },
      },
      sequelize,
      modelName: "user",
    }
  );
  return user;
};
