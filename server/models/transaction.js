'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class transaction extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      transaction.belongsTo(models.user, { foreignKey: "userId" });
      transaction.belongsTo(models.courier, { foreignKey: "courierId" });
      transaction.belongsTo(models.product, { foreignKey: "productId" });
    }
  }
  transaction.init({
    userId: DataTypes.INTEGER,
    productId: DataTypes.INTEGER,
    midtranstoken: DataTypes.STRING,
    status: DataTypes.ENUM('pending','reject','approve')
  }, {
    sequelize,
    modelName: 'transaction',
  });
  return transaction;
};