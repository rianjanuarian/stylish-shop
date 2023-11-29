"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable("History", {
      id: {
        type: Sequelize.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
      },
      userId: {
        type: Sequelize.INTEGER,
      },
      status: {
        type: Sequelize.ENUM("pending", "reject", "approve"),
      },
      productId: {
        type: Sequelize.INTEGER,
      },
      variant: {
        type: Sequelize.STRING,
      },
      orderId: {
        type: Sequelize.STRING,
      },
      midtransToken: {
        type: Sequelize.STRING,
      },
    });
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable("History");
  },
};
