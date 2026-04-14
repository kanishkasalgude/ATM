const router = require('express').Router();
const { pool } = require('../db');

// All active alerts
router.get('/', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT al.*, a.serial_number, a.location_address, b.city,
             CONCAT(e.first_name,' ',e.last_name) AS resolved_by_name,
             TIMESTAMPDIFF(MINUTE, al.created_at, NOW()) AS age_minutes
      FROM ATM_ALERT al
      JOIN ATM    a ON al.atm_id = a.atm_id
      JOIN BRANCH b ON a.branch_id = b.branch_id
      LEFT JOIN EMPLOYEE e ON al.resolved_by = e.employee_id
      ORDER BY FIELD(al.severity,'critical','high','medium','low'), al.created_at DESC`);
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Resolve alert
router.patch('/:id/resolve', async (req, res) => {
  try {
    const { resolved_by } = req.body;
    const conn = await pool.getConnection();

    // Get alert data for audit
    const [[alert]] = await conn.query('SELECT * FROM ATM_ALERT WHERE alert_id=?', [req.params.id]);
    await conn.query(
      "UPDATE ATM_ALERT SET status='resolved', resolved_by=?, resolved_at=NOW() WHERE alert_id=?",
      [resolved_by, req.params.id]
    );

    // Audit log
    await conn.query(
      `INSERT INTO AUDIT_LOG (entity_type,entity_id,action,changed_by,old_values,new_values)
       VALUES ('ATM_ALERT',?,?,?,?,?)`,
      [req.params.id, 'update', resolved_by,
        JSON.stringify({ status: alert.status }),
        JSON.stringify({ status: 'resolved' })]
    );
    conn.release();
    res.json({ success: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Audit log
router.get('/audit', async (req, res) => {
  try {
    const { page = 1, limit = 30 } = req.query;
    const offset = (page - 1) * limit;
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT al.*, CONCAT(e.first_name,' ',e.last_name) AS changed_by_name
      FROM AUDIT_LOG al
      LEFT JOIN EMPLOYEE e ON al.changed_by = e.employee_id
      ORDER BY al.changed_at DESC
      LIMIT ? OFFSET ?`, [parseInt(limit), parseInt(offset)]);
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
