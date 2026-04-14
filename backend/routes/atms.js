const router = require('express').Router();
const { pool } = require('../db');

// List all ATMs
router.get('/', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [atms] = await conn.query(`
      SELECT a.*, b.branch_name, b.city, b.state,
             bk.bank_name,
             COALESCE(SUM(ac.current_count * d.value), 0) AS current_cash
      FROM ATM a
      JOIN BRANCH b ON a.branch_id = b.branch_id
      JOIN BANK  bk ON b.bank_id = bk.bank_id
      LEFT JOIN ATM_CASSETTE ac ON a.atm_id = ac.atm_id
      LEFT JOIN DENOMINATION d  ON ac.denomination_id = d.denomination_id
      GROUP BY a.atm_id
      ORDER BY a.atm_id
    `);
    conn.release();
    res.json(atms);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Get ATM details + cassettes
router.get('/:id', async (req, res) => {
  try {
    const conn   = await pool.getConnection();
    const [[atm]] = await conn.query(`
      SELECT a.*, b.branch_name, b.city, b.state, bk.bank_name
      FROM ATM a
      JOIN BRANCH b ON a.branch_id = b.branch_id
      JOIN BANK  bk ON b.bank_id = bk.bank_id
      WHERE a.atm_id = ?`, [req.params.id]);

    const [cassettes] = await conn.query(`
      SELECT ac.*, d.value, d.description, d.currency_code,
             (ac.current_count * d.value) AS cash_value
      FROM ATM_CASSETTE ac
      JOIN DENOMINATION d ON ac.denomination_id = d.denomination_id
      WHERE ac.atm_id = ?
      ORDER BY d.value DESC`, [req.params.id]);

    conn.release();
    if (!atm) return res.status(404).json({ error: 'ATM not found' });
    res.json({ ...atm, cassettes });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Create ATM
router.post('/', async (req, res) => {
  try {
    const {
      branch_id, serial_number, model, manufacturer, location_address,
      latitude, longitude, atm_type, installation_date, max_capacity,
      software_version, status
    } = req.body;
    const conn = await pool.getConnection();
    const [result] = await conn.query(
      `INSERT INTO ATM (branch_id,serial_number,model,manufacturer,location_address,latitude,longitude,atm_type,installation_date,max_capacity,software_version,status)
       VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
      [branch_id,serial_number,model,manufacturer,location_address,latitude,longitude,atm_type||'onsite',installation_date,max_capacity||500000,software_version,status||'active']
    );
    conn.release();
    res.status(201).json({ atm_id: result.insertId });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Update ATM
router.put('/:id', async (req, res) => {
  try {
    const fields = ['model','manufacturer','location_address','atm_type','max_capacity','software_version','status'];
    const updates = fields.filter(f => req.body[f] !== undefined).map(f => `${f}=?`).join(', ');
    const values  = fields.filter(f => req.body[f] !== undefined).map(f => req.body[f]);
    if (!updates) return res.status(400).json({ error: 'No fields to update' });
    const conn = await pool.getConnection();
    await conn.query(`UPDATE ATM SET ${updates} WHERE atm_id=?`, [...values, req.params.id]);
    conn.release();
    res.json({ success: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// Deactivate ATM
router.patch('/:id/deactivate', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    await conn.query("UPDATE ATM SET status='inactive' WHERE atm_id=?", [req.params.id]);
    conn.release();
    res.json({ success: true });
  } catch (e) { res.status(500).json({ error: e.message }); }
});

// List branches (for ATM form dropdown)
router.get('/meta/branches', async (req, res) => {
  try {
    const conn = await pool.getConnection();
    const [rows] = await conn.query('SELECT branch_id, branch_name, city FROM BRANCH WHERE status="active"');
    conn.release();
    res.json(rows);
  } catch (e) { res.status(500).json({ error: e.message }); }
});

module.exports = router;
