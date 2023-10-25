'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class categoryproduct extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
          categoryproduct.belongsTo(models.category)
      categoryproduct.belongsTo(models.product)
        // brandproduct.belongsTo(models.brand)
     // brandproduct.belongsTo(models.product)
    }
  }
  categoryproduct.init({
    productId: DataTypes.INTEGER,
    categoryId: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'categoryproduct',
  });
  return categoryproduct;
};