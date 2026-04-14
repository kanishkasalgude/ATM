const mysql = require('mysql2/promise');
require('dotenv').config();
const fs = require('fs');
const path = require('path');

const pool = mysql.createPool({
  host:     process.env.DB_HOST     || 'localhost',
  port:     parseInt(process.env.DB_PORT || '3306'),
  user:     process.env.DB_USER     || 'root',
  password: process.env.DB_PASSWORD !== undefined ? process.env.DB_PASSWORD : 'root',
  database: process.env.DB_NAME     || 'atm_cash_mgmt',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  multipleStatements: true,
});

async function initDB() {
  const conn = await mysql.createConnection({
    host:     process.env.DB_HOST     || 'localhost',
    port:     parseInt(process.env.DB_PORT || '3306'),
    user:     process.env.DB_USER     || 'root',
    password: process.env.DB_PASSWORD !== undefined ? process.env.DB_PASSWORD : 'root',
    multipleStatements: true,
  });

  try {
    await conn.query('CREATE DATABASE IF NOT EXISTS atm_cash_mgmt');
    await conn.query('USE atm_cash_mgmt');

    const [tables] = await conn.query("SHOW TABLES LIKE 'BANK'");
    if (tables.length === 0) {
      // Run schema
      const schema = fs.readFileSync(path.join(__dirname, 'db', 'schema.sql'), 'utf8');
      await conn.query(schema);
      console.log('✅ Schema applied');

      // Check if seeded
      const [rows] = await conn.query('SELECT COUNT(*) as cnt FROM BANK');
      if (rows[0].cnt === 0) {
        const seed = fs.readFileSync(path.join(__dirname, 'db', 'seed.sql'), 'utf8');
        await conn.query(seed);
        console.log('✅ Seed data loaded');
      } else {
        console.log('ℹ️  Database already seeded, skipping.');
      }
    } else {
      console.log('ℹ️  Database schema already exists, skipping initialization.');
    }
  } catch (err) {
    console.error('❌ DB init error:', err.message);
    throw err;
  } finally {
    await conn.end();
  }
}

module.exports = { pool, initDB };
