const router = require('express').Router();
const { pool } = require('../db');

// List all replenishments
router.get('/', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query(`
      SELECT r.*,
             a.serial_number, a.location_address, b.city,
             v.vendor_name, v.contact_person,
             CONCAT(e1.first_name,' ',e1.last_name) AS requested_by_name,
             CONCAT(e2.first_name,' ',e2.last_name) AS approved_by_name
      FROM CASH_REPLENISHMENT r
      JOIN ATM a       ON r.atm_id = a.atm_id
      JOIN BRANCH b    ON a.branch_id = b.branch_id
      JOIN CIT_VENDOR v ON r.vendor_id = v.vendor_id
      LEFT JOIN EMPLOYEE e1 ON r.requested_by = e1.employee_id
      LEFT JOIN EMPLOYEE e2 ON r.approved_by  = e2.employee_id
      ORDER BY r.request_date DESC`);
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Get replenishment details
router.get('/:id', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [[rep]] = await conn.query(`
      SELECT r.*,
             a.serial_number, a.location_address, b.city,
             v.vendor_name,
             CONCAT(e1.first_name,' ',e1.last_name) AS requested_by_name,
             CONCAT(e2.first_name,' ',e2.last_name) AS approved_by_name
      FROM CASH_REPLENISHMENT r
      JOIN ATM a        ON r.atm_id = a.atm_id
      JOIN BRANCH b     ON a.branch_id = b.branch_id
      JOIN CIT_VENDOR v ON r.vendor_id = v.vendor_id
      LEFT JOIN EMPLOYEE e1 ON r.requested_by = e1.employee_id
      LEFT JOIN EMPLOYEE e2 ON r.approved_by  = e2.employee_id
      WHERE r.replenishment_id = ?`, [req.params.id]);

    const [details] = await conn.query(`
      SELECT rd.*, d.value, d.description
      FROM REPLENISHMENT_DETAIL rd
      JOIN DENOMINATION d ON rd.denomination_id = d.denomination_id
      WHERE rd.replenishment_id = ?`, [req.params.id]);

    conn.release();
    res.json({ ...rep, details });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Create replenishment
router.post('/', async (req, res) => {
  try {
    const { atm_id, vendor_id, requested_by, scheduled_date, total_amount, notes, denominations } = req.body;
    const conn = await pool.getConnection();
    const [result] = await conn.query(
      `INSERT INTO CASH_REPLENISHMENT (atm_id,vendor_id,requested_by,scheduled_date,total_amount,status,notes)
       VALUES (?,?,?,?,?,'pending',?)`,
      [atm_id, vendor_id, requested_by, scheduled_date, total_amount, notes]
    );
    const repId = result.insertId;

    if (denominations && denominations.length) {
      for (const d of denominations) {
        await conn.query(
          'INSERT INTO REPLENISHMENT_DETAIL (replenishment_id,denomination_id,notes_count,amount) VALUES (?,?,?,?)',
          [repId, d.denomination_id, d.notes_count, d.notes_count * d.value]
        );
      }
    }
    conn.release();
    res.status(201).json({ replenishment_id: repId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Approve replenishment
router.patch('/:id/approve', async (req, res) => {
  try {
    const { approved_by } = req.body;
    const conn = await pool.getConnection();
    await conn.query(
      "UPDATE CASH_REPLENISHMENT SET status='approved', approved_by=? WHERE replenishment_id=?",
      [approved_by, req.params.id]
    );
    conn.release();
    res.json({ success: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Mark completed
router.patch('/:id/complete', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    await conn.query(
      "UPDATE CASH_REPLENISHMENT SET status='completed', actual_date=NOW() WHERE replenishment_id=?",
      [req.params.id]
    );
    conn.release();
    res.json({ success: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Meta: vendors, ATMs for form dropdowns
router.get('/meta/options', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [vendors]  = await conn.query("SELECT vendor_id, vendor_name FROM CIT_VENDOR WHERE status='active'");
    const [atms]     = await conn.query("SELECT a.atm_id, a.serial_number, a.location_address, b.city FROM ATM a JOIN BRANCH b ON a.branch_id=b.branch_id WHERE a.status='active'");
    const [emps]     = await conn.query("SELECT employee_id, CONCAT(first_name,' ',last_name) AS name, role FROM EMPLOYEE WHERE status='active'");
    const [denoms]   = await conn.query("SELECT denomination_id, value, description FROM DENOMINATION ORDER BY value DESC");
    conn.release();
    res.json({ vendors, atms, employees: emps, denominations: denoms });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
