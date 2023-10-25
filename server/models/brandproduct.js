'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class brandproduct extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  brandproduct.init({
    products_id: DataTypes.INTEGER,
    brands_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'brandproduct',
  });
  return brandproduct;
};