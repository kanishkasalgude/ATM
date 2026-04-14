const router = require('express').Router();
const { pool } = require('../db');

// ---- BANKS ----
router.get('/banks', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query('SELECT * FROM BANK ORDER BY bank_id');
  conn.release(); res.json(rows);
});
router.post('/banks', async (req, res) => {
  try {
    const { bank_name, swift_code, headquarters, phone, established_date, status } = req.body;
    const conn = await pool.getConnection();
    const [r] = await conn.query(
      'INSERT INTO BANK (bank_name,swift_code,headquarters,phone,established_date,status) VALUES (?,?,?,?,?,?)',
      [bank_name,swift_code,headquarters,phone,established_date,status||'active']);
    conn.release(); res.status(201).json({ bank_id: r.insertId });
  } catch(e){ res.status(500).json({error:e.message}); }
});
router.put('/banks/:id', async (req, res) => {
  try {
    const { bank_name, headquarters, phone, status } = req.body;
    const conn = await pool.getConnection();
    await conn.query('UPDATE BANK SET bank_name=?,headquarters=?,phone=?,status=? WHERE bank_id=?',
      [bank_name,headquarters,phone,status,req.params.id]);
    conn.release(); res.json({success:true});
  } catch(e){ res.status(500).json({error:e.message}); }
});

// ---- BRANCHES ----
router.get('/branches', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query(`
    SELECT br.*, bk.bank_name, CONCAT(e.first_name,' ',e.last_name) AS manager_name
    FROM BRANCH br
    JOIN BANK bk ON br.bank_id = bk.bank_id
    LEFT JOIN EMPLOYEE e ON br.manager_id = e.employee_id
    ORDER BY br.branch_id`);
  conn.release(); res.json(rows);
});
router.post('/branches', async (req, res) => {
  try {
    const { bank_id, manager_id, branch_name, ifsc_code, address, city, state, status } = req.body;
    const conn = await pool.getConnection();
    const [r] = await conn.query(
      'INSERT INTO BRANCH (bank_id,manager_id,branch_name,ifsc_code,address,city,state,status) VALUES (?,?,?,?,?,?,?,?)',
      [bank_id,manager_id||null,branch_name,ifsc_code,address,city,state,status||'active']);
    conn.release(); res.status(201).json({ branch_id: r.insertId });
  } catch(e){ res.status(500).json({error:e.message}); }
});
router.put('/branches/:id', async (req, res) => {
  try {
    const { branch_name, address, city, state, status } = req.body;
    const conn = await pool.getConnection();
    await conn.query('UPDATE BRANCH SET branch_name=?,address=?,city=?,state=?,status=? WHERE branch_id=?',
      [branch_name,address,city,state,status,req.params.id]);
    conn.release(); res.json({success:true});
  } catch(e){ res.status(500).json({error:e.message}); }
});

// ---- EMPLOYEES ----
router.get('/employees', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query(`
    SELECT e.*, b.branch_name, b.city FROM EMPLOYEE e
    LEFT JOIN BRANCH b ON e.branch_id = b.branch_id
    ORDER BY e.employee_id`);
  conn.release(); res.json(rows);
});
router.post('/employees', async (req, res) => {
  try {
    const { branch_id, first_name, last_name, email, phone, role, hire_date, status } = req.body;
    const conn = await pool.getConnection();
    const [r] = await conn.query(
      'INSERT INTO EMPLOYEE (branch_id,first_name,last_name,email,phone,role,hire_date,status) VALUES (?,?,?,?,?,?,?,?)',
      [branch_id,first_name,last_name,email,phone,role,hire_date,status||'active']);
    conn.release(); res.status(201).json({ employee_id: r.insertId });
  } catch(e){ res.status(500).json({error:e.message}); }
});
router.put('/employees/:id', async (req, res) => {
  try {
    const { first_name, last_name, email, phone, role, status } = req.body;
    const conn = await pool.getConnection();
    await conn.query('UPDATE EMPLOYEE SET first_name=?,last_name=?,email=?,phone=?,role=?,status=? WHERE employee_id=?',
      [first_name,last_name,email,phone,role,status,req.params.id]);
    conn.release(); res.json({success:true});
  } catch(e){ res.status(500).json({error:e.message}); }
});

// ---- CUSTOMERS ----
router.get('/customers', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query('SELECT * FROM CUSTOMER ORDER BY customer_id');
  conn.release(); res.json(rows);
});
router.post('/customers', async (req, res) => {
  try {
    const { first_name, last_name, date_of_birth, email, phone, aadhar_number, pan_number, kyc_status, status } = req.body;
    const conn = await pool.getConnection();
    const [r] = await conn.query(
      'INSERT INTO CUSTOMER (first_name,last_name,date_of_birth,email,phone,aadhar_number,pan_number,kyc_status,status) VALUES (?,?,?,?,?,?,?,?,?)',
      [first_name,last_name,date_of_birth,email,phone,aadhar_number,pan_number,kyc_status||'pending',status||'active']);
    conn.release(); res.status(201).json({ customer_id: r.insertId });
  } catch(e){ res.status(500).json({error:e.message}); }
});

// ---- CARDS ----
router.get('/cards', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query(`
    SELECT c.*, CONCAT(cu.first_name,' ',cu.last_name) AS customer_name, ac.account_number
    FROM CARD c
    JOIN CUSTOMER cu ON c.customer_id = cu.customer_id
    JOIN ACCOUNT  ac ON c.account_id  = ac.account_id
    ORDER BY c.card_id`);
  conn.release(); res.json(rows);
});

// ---- CIT VENDORS ----
router.get('/vendors', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query('SELECT * FROM CIT_VENDOR ORDER BY vendor_id');
  conn.release(); res.json(rows);
});
router.post('/vendors', async (req, res) => {
  try {
    const { vendor_name, contact_person, phone, email, license_number, contract_start, contract_end, status } = req.body;
    const conn = await pool.getConnection();
    const [r] = await conn.query(
      'INSERT INTO CIT_VENDOR (vendor_name,contact_person,phone,email,license_number,contract_start,contract_end,status) VALUES (?,?,?,?,?,?,?,?)',
      [vendor_name,contact_person,phone,email,license_number,contract_start,contract_end,status||'active']);
    conn.release(); res.status(201).json({ vendor_id: r.insertId });
  } catch(e){ res.status(500).json({error:e.message}); }
});
router.put('/vendors/:id', async (req, res) => {
  try {
    const { vendor_name, contact_person, phone, email, status } = req.body;
    const conn = await pool.getConnection();
    await conn.query('UPDATE CIT_VENDOR SET vendor_name=?,contact_person=?,phone=?,email=?,status=? WHERE vendor_id=?',
      [vendor_name,contact_person,phone,email,status,req.params.id]);
    conn.release(); res.json({success:true});
  } catch(e){ res.status(500).json({error:e.message}); }
});

// ---- DENOMINATIONS ----
router.get('/denominations', async (req, res) => {
  const conn = await pool.getConnection();
  const [rows] = await conn.query('SELECT * FROM DENOMINATION ORDER BY value DESC');
  conn.release(); res.json(rows);
});
router.post('/denominations', async (req, res) => {
  try {
    const { currency_code, value, description } = req.body;
    const conn = await pool.getConnection();
    const [r] = await conn.query(
      'INSERT INTO DENOMINATION (currency_code,value,description) VALUES (?,?,?)',
      [currency_code||'INR',value,description]);
    conn.release(); res.status(201).json({ denomination_id: r.insertId });
  } catch(e){ res.status(500).json({error:e.message}); }
});

module.exports = router;
