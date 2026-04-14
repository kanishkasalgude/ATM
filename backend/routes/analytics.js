const router = require('express').Router();
const { pool } = require('../db');

// Moving average: last N days withdrawals per ATM
router.get('/moving-average/:atm_id', async (req, res) => {
  try {
    const { atm_id } = req.params;
    const n = parseInt(req.query.n || '7');
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT DATE(txn_datetime) AS date,
             COALESCE(SUM(amount), 0) AS total
      FROM \`TRANSACTION\`
      WHERE atm_id = ? AND status = 'success'
        AND txn_datetime >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
      GROUP BY DATE(txn_datetime)
      ORDER BY date ASC`, [atm_id, n]);
    conn.release();

    const values = rows.map(r => parseFloat(r.total));
    const avg    = values.length ? values.reduce((a, b) => a + b, 0) / values.length : 0;
    res.json({ data: rows, n, avg, avgLakhs: +(avg / 100000).toFixed(2), days: values });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// 30-day withdrawal data for simulation
router.get('/simulation-data/:atm_id', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT DATE(txn_datetime) AS date,
             COALESCE(SUM(amount), 0) AS total
      FROM \`TRANSACTION\`
      WHERE atm_id = ? AND status = 'success'
        AND txn_datetime >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
      GROUP BY DATE(txn_datetime)
      ORDER BY date ASC`, [req.params.atm_id]);
    conn.release();
    res.json(rows.map(r => ({ date: r.date, demand: parseFloat(r.total) })));
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// All ATMs list for analytics dropdowns
router.get('/atm-list', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT a.atm_id, a.serial_number, a.location_address, b.city
      FROM ATM a JOIN BRANCH b ON a.branch_id = b.branch_id
      ORDER BY a.atm_id`);
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
