const router = require('express').Router();
const { pool } = require('../db');

// List transactions with filters
router.get('/', async (req, res) => {
  try {
    const { atm_id, start_date, end_date, status, type, page = 1, limit = 20 } = req.query;
    const offset = (page - 1) * limit;
    let where = ['1=1'];
    let params = [];

    if (atm_id)     { where.push('t.atm_id=?');           params.push(atm_id); }
    if (status)     { where.push('t.status=?');            params.push(status); }
    if (type)       { where.push('t.transaction_type=?');  params.push(type); }
    if (start_date) { where.push('DATE(t.txn_datetime)>=?');params.push(start_date); }
    if (end_date)   { where.push('DATE(t.txn_datetime)<=?');params.push(end_date); }

    const whereStr = where.join(' AND ');
    const conn = await pool.getConnection();

    const [[{ total }]] = await conn.query(
      `SELECT COUNT(*) as total FROM \`TRANSACTION\` t WHERE ${whereStr}`, params);

    const [rows] = await conn.query(`
      SELECT t.*, a.serial_number, a.location_address, b.city,
             c.card_type, c.network
      FROM \`TRANSACTION\` t
      JOIN ATM a    ON t.atm_id = a.atm_id
      JOIN BRANCH b ON a.branch_id = b.branch_id
      LEFT JOIN CARD c ON t.card_id = c.card_id
      WHERE ${whereStr}
      ORDER BY t.txn_datetime DESC
      LIMIT ? OFFSET ?`, [...params, parseInt(limit), parseInt(offset)]);

    conn.release();
    res.json({ data: rows, total, page: parseInt(page), limit: parseInt(limit) });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Transaction denomination breakdown
router.get('/:id/denominations', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT td.*, d.value, d.description, (td.notes_count * d.value) AS subtotal
      FROM TXN_DENOMINATION td
      JOIN DENOMINATION d ON td.denomination_id = d.denomination_id
      WHERE td.transaction_id = ?`, [req.params.id]);
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Summary stats
router.get('/stats/summary', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [[today]] = await conn.query(`
      SELECT COUNT(*) as total_txns,
             COALESCE(SUM(CASE WHEN status='success' THEN amount END),0) as total_amount,
             ROUND(SUM(CASE WHEN status='success' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) as success_rate
      FROM \`TRANSACTION\` WHERE DATE(txn_datetime)=CURDATE()`);

    const [hourly] = await conn.query(`
      SELECT HOUR(txn_datetime) as hour, COUNT(*) as count
      FROM \`TRANSACTION\`
      WHERE DATE(txn_datetime)=CURDATE() AND status='success'
      GROUP BY HOUR(txn_datetime)
      ORDER BY hour`);

    conn.release();
    res.json({
      todayTxns:    today.total_txns,
      todayAmount:  parseFloat(today.total_amount),
      successRate:  parseFloat(today.success_rate || 0),
      hourlyData:   hourly,
    });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Export CSV
router.get('/export/csv', async (req, res) => {
  try {
    const { atm_id, start_date, end_date, status } = req.query;
    let where = ['1=1']; let params = [];
    if (atm_id)     { where.push('t.atm_id=?');            params.push(atm_id); }
    if (status)     { where.push('t.status=?');             params.push(status); }
    if (start_date) { where.push('DATE(t.txn_datetime)>=?');params.push(start_date); }
    if (end_date)   { where.push('DATE(t.txn_datetime)<=?');params.push(end_date); }

    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT t.transaction_id, t.reference_number, t.txn_datetime, t.transaction_type,
             t.amount, t.status, t.failure_reason,
             a.serial_number AS atm_serial, a.location_address
      FROM \`TRANSACTION\` t
      JOIN ATM a ON t.atm_id = a.atm_id
      WHERE ${where.join(' AND ')}
      ORDER BY t.txn_datetime DESC`, params);
    conn.release();

    const headers = Object.keys(rows[0] || {}).join(',');
    const csvRows = rows.map(r => Object.values(r).map(v => `"${v ?? ''}"`).join(',')).join('\n');
    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', 'attachment; filename="transactions.csv"');
    res.send(`${headers}\n${csvRows}`);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
