const router = require('express').Router();
const { pool } = require('../db');

// KPI cards
router.get('/kpis', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [[totalAtms]]     = await conn.query('SELECT COUNT(*) as cnt FROM ATM');
    const [[activeAtms]]    = await conn.query("SELECT COUNT(*) as cnt FROM ATM WHERE status='active'");
    const [[todayTxns]]     = await conn.query(
      "SELECT COUNT(*) as cnt, COALESCE(SUM(amount),0) as total FROM `TRANSACTION` WHERE DATE(txn_datetime)=CURDATE() AND status='success'"
    );
    const [[lowCashAlerts]] = await conn.query(
      "SELECT COUNT(*) as cnt FROM ATM_ALERT WHERE alert_type='low_cash' AND status='active'"
    );
    conn.release();

    res.json({
      totalAtms:     totalAtms.cnt,
      activeAtms:    activeAtms.cnt,
      todayTxns:     todayTxns.cnt,
      todayAmount:   parseFloat(todayTxns.total),
      lowCashAlerts: lowCashAlerts.cnt,
    });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// ATM status grid
router.get('/atm-status', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [atms] = await conn.query(`
      SELECT a.atm_id, a.serial_number, a.location_address, a.status, a.max_capacity,
             b.branch_name, b.city,
             COALESCE(SUM(ac.current_count * d.value), 0) AS current_cash,
             MAX(al.alert_type) AS latest_alert,
             MAX(al.severity) AS latest_severity
      FROM ATM a
      JOIN BRANCH b ON a.branch_id = b.branch_id
      LEFT JOIN ATM_CASSETTE ac ON a.atm_id = ac.atm_id
      LEFT JOIN DENOMINATION d  ON ac.denomination_id = d.denomination_id
      LEFT JOIN ATM_ALERT al    ON a.atm_id = al.atm_id AND al.status = 'active'
      GROUP BY a.atm_id
      ORDER BY a.atm_id
    `);
    conn.release();
    res.json(atms);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// 7-day withdrawal chart
router.get('/weekly-chart', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT DATE(txn_datetime) AS date,
             COALESCE(SUM(amount), 0) AS total,
             COUNT(*) AS count
      FROM \`TRANSACTION\`
      WHERE txn_datetime >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
        AND status = 'success'
      GROUP BY DATE(txn_datetime)
      ORDER BY date ASC
    `);
    conn.release();
    res.json(rows.map(r => ({
      date:     r.date,
      total:    parseFloat(r.total),
      count:    r.count,
      totalL:   +(parseFloat(r.total) / 100000).toFixed(2),
    })));
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Recent alerts
router.get('/recent-alerts', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT al.alert_id, al.alert_type, al.severity, al.message, al.created_at, al.status,
             a.serial_number, a.location_address, b.city
      FROM ATM_ALERT al
      JOIN ATM    a ON al.atm_id = a.atm_id
      JOIN BRANCH b ON a.branch_id = b.branch_id
      WHERE al.status = 'active'
      ORDER BY FIELD(al.severity,'critical','high','medium','low'), al.created_at DESC
      LIMIT 5
    `);
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
