const { Pool } = require("pg");
const Sequelize = require("sequelize");

const pool = new Pool({
  connectionString: process.env.POSTGRES_URL + "?sslmode=require",
});

pool.connect((err) => {
  if (err) throw err;
  console.log("Connected to PostgreSQL successfully!");
});

const sequelize = new Sequelize(process.env.POSTGRES_URL, {
  dialect: "postgres",
  dialectOptions: {
    ssl: {
      require: true,
      rejectUnauthorized: false, // to avoid self-signed certificate error
    },
  },
});

module.exports = { pool, sequelize };
