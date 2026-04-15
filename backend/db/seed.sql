-- =============================================================
-- ATM Cash Management System — Seed Data
-- PICT Pune Mini Project
-- =============================================================

USE atm_cash_mgmt;

-- ===================== BANK =====================
INSERT INTO BANK (bank_name, swift_code, headquarters, phone, established_date, status) VALUES
('State Bank of India', 'SBININBB', 'State Bank Bhavan, Mumbai, Maharashtra', '1800-11-2211', '1955-07-01', 'active');

-- ===================== EMPLOYEE (without branch_id first) =====================
INSERT INTO EMPLOYEE (branch_id, first_name, last_name, email, phone, role, hire_date, status) VALUES
(NULL, 'Rajesh', 'Kumar',   'rajesh.kumar@sbi.co.in',   '9823001001', 'manager',    '2015-06-01', 'active'),
(NULL, 'Priya',  'Sharma',  'priya.sharma@sbi.co.in',   '9823001002', 'technician', '2018-03-15', 'active'),
(NULL, 'Amit',   'Desai',   'amit.desai@sbi.co.in',     '9823001003', 'cashier',    '2020-01-10', 'active'),
(NULL, 'Sunita', 'Patil',   'sunita.patil@sbi.co.in',   '9823001004', 'manager',    '2016-09-20', 'active'),
(NULL, 'Vikram', 'Joshi',   'vikram.joshi@sbi.co.in',   '9823001005', 'technician', '2019-07-01', 'active'),
(NULL, 'Neha',   'Kulkarni','neha.kulkarni@sbi.co.in',  '9823001006', 'cashier',    '2021-04-15', 'active'),
(NULL, 'Arjun',  'Singh',   'arjun.singh@sbi.co.in',    '9823001007', 'manager',    '2014-11-01', 'active'),
(NULL, 'Pooja',  'Mehta',   'pooja.mehta@sbi.co.in',    '9823001008', 'technician', '2017-05-20', 'active'),
(NULL, 'Suresh', 'Verma',   'suresh.verma@sbi.co.in',   '9823001009', 'cashier',    '2022-02-01', 'active');

-- ===================== BRANCH =====================
INSERT INTO BRANCH (bank_id, manager_id, branch_name, ifsc_code, address, city, state, status) VALUES
(1, 1, 'SBI Mumbai Main Branch',          'SBIN0001001', 'Madame Cama Road, Nariman Point', 'Mumbai',    'Maharashtra', 'active'),
(1, 4, 'SBI Pune Koregaon Park Branch',   'SBIN0001002', 'Lane 5, Koregaon Park',           'Pune',      'Maharashtra', 'active'),
(1, 7, 'SBI Delhi Connaught Place Branch','SBIN0001003', 'Block A, Connaught Place',        'New Delhi',  'Delhi',       'active');

-- ===================== Update EMPLOYEE branch_id =====================
UPDATE EMPLOYEE SET branch_id = 1 WHERE employee_id IN (1,2,3);
UPDATE EMPLOYEE SET branch_id = 2 WHERE employee_id IN (4,5,6);
UPDATE EMPLOYEE SET branch_id = 3 WHERE employee_id IN (7,8,9);

-- ===================== DENOMINATION =====================
INSERT INTO DENOMINATION (currency_code, value, description) VALUES
('INR', 500.00, 'Five Hundred Rupees'),
('INR', 200.00, 'Two Hundred Rupees'),
('INR', 100.00, 'One Hundred Rupees'),
('INR', 50.00,  'Fifty Rupees');

-- ===================== ATM =====================
INSERT INTO ATM (branch_id, serial_number, model, manufacturer, location_address, latitude, longitude, atm_type, installation_date, max_capacity, software_version, status) VALUES
(1, 'SBI-ATM-MUM-001', 'Diebold Nixdorf DN200', 'Diebold Nixdorf', 'Nariman Point, Mumbai',      18.9247, 72.8318, 'onsite',  '2019-03-15', 13000000, 'v3.4.1', 'active'),
(1, 'SBI-ATM-MUM-002', 'NCR SelfServ 34',        'NCR Corporation', 'Bandra West, Mumbai',        19.0600, 72.8340, 'offsite', '2020-06-10', 10000000, 'v4.1.0', 'active'),
(2, 'SBI-ATM-PUN-001', 'Diebold Nixdorf DN500', 'Diebold Nixdorf', 'Koregaon Park, Pune',        18.5362, 73.8905, 'onsite',  '2018-11-20', 13000000, 'v3.4.1', 'active'),
(2, 'SBI-ATM-PUN-002', 'Hyosung MX5600XP',       'Nautilus Hyosung','Camp Area, Pune',            18.5167, 73.8553, 'offsite', '2021-02-14', 10000000, 'v2.9.3', 'maintenance'),
(3, 'SBI-ATM-DEL-001', 'NCR SelfServ 87',        'NCR Corporation', 'Connaught Place, New Delhi', 28.6315, 77.2167, 'onsite',  '2017-08-05', 15000000, 'v4.2.1', 'active');

-- ===================== ATM_CASSETTE =====================
-- ATM 1 (MUM-001): 4 cassettes
INSERT INTO ATM_CASSETTE (atm_id, denomination_id, cassette_slot, max_capacity, current_count, low_threshold, status) VALUES
(1, 1, 1, 2000, 1850, 200, 'active'),
(1, 2, 2, 2000,  900, 200, 'active'),
(1, 3, 3, 2000, 1200, 200, 'active'),
(1, 4, 4, 2000,  600, 200, 'active');
-- ATM 2 (MUM-002)
INSERT INTO ATM_CASSETTE (atm_id, denomination_id, cassette_slot, max_capacity, current_count, low_threshold, status) VALUES
(2, 1, 1, 2000, 1600, 200, 'active'),
(2, 2, 2, 2000,  700, 200, 'active'),
(2, 3, 3, 2000,  500, 200, 'active'),
(2, 4, 4, 2000,  300, 200, 'active');
-- ATM 3 (PUN-001)
INSERT INTO ATM_CASSETTE (atm_id, denomination_id, cassette_slot, max_capacity, current_count, low_threshold, status) VALUES
(3, 1, 1, 2000,  180, 200, 'active'),
(3, 2, 2, 2000,  400, 200, 'active'),
(3, 3, 3, 2000,  800, 200, 'active'),
(3, 4, 4, 2000,  250, 200, 'active');
-- ATM 4 (PUN-002 — maintenance)
INSERT INTO ATM_CASSETTE (atm_id, denomination_id, cassette_slot, max_capacity, current_count, low_threshold, status) VALUES
(4, 1, 1, 2000,    0, 200, 'empty'),
(4, 2, 2, 2000,    0, 200, 'empty'),
(4, 3, 3, 2000,    0, 200, 'empty'),
(4, 4, 4, 2000,    0, 200, 'empty');
-- ATM 5 (DEL-001)
INSERT INTO ATM_CASSETTE (atm_id, denomination_id, cassette_slot, max_capacity, current_count, low_threshold, status) VALUES
(5, 1, 1, 2500, 2200, 250, 'active'),
(5, 2, 2, 2500,  900, 250, 'active'),
(5, 3, 3, 2500, 1400, 250, 'active'),
(5, 4, 4, 2500,  800, 250, 'active');

-- ===================== CUSTOMER =====================
INSERT INTO CUSTOMER (first_name, last_name, date_of_birth, email, phone, aadhar_number, pan_number, kyc_status, status) VALUES
('Rahul',   'Gupta',   '1990-04-15', 'rahul.gupta@gmail.com',   '9911001001', '2345678901234501', 'BCDPG1234A', 'verified', 'active'),
('Sneha',   'Nair',    '1992-08-22', 'sneha.nair@gmail.com',    '9911001002', '2345678901234502', 'CDEPN2345B', 'verified', 'active'),
('Karan',   'Malhotra','1988-12-05', 'karan.malhotra@gmail.com','9911001003', '2345678901234503', 'DEFPM3456C', 'verified', 'active'),
('Anjali',  'Reddy',   '1995-03-30', 'anjali.reddy@gmail.com',  '9911001004', '2345678901234504', 'EFGPR4567D', 'verified', 'active'),
('Mohit',   'Sharma',  '1985-11-18', 'mohit.sharma@gmail.com',  '9911001005', '2345678901234505', 'FGHPS5678E', 'verified', 'active');

-- ===================== ACCOUNT =====================
INSERT INTO ACCOUNT (customer_id, branch_id, account_number, account_type, balance, daily_withdrawal_limit, opening_date, status) VALUES
(1, 1, '35001234567890', 'savings',  125000.00, 20000.00, '2018-06-01', 'active'),
(2, 1, '35001234567891', 'savings',   87500.00, 20000.00, '2019-03-15', 'active'),
(3, 2, '35002234567892', 'current',  350000.00, 50000.00, '2017-09-20', 'active'),
(4, 2, '35002234567893', 'savings',   62000.00, 20000.00, '2020-11-01', 'active'),
(5, 3, '35003234567894', 'salary',   210000.00, 30000.00, '2016-04-05', 'active');

-- ===================== CARD =====================
INSERT INTO CARD (account_id, customer_id, card_number_hash, card_type, network, issue_date, expiry_date, pin_hash, daily_limit, international_enabled, contactless_enabled, status) VALUES
(1, 1, SHA2('4111111111111001',256), 'debit', 'visa',       '2022-01-01', '2027-01-31', SHA2('1234',256), 20000.00, FALSE, TRUE,  'active'),
(2, 2, SHA2('4111111111111002',256), 'debit', 'rupay',      '2021-06-15', '2026-06-30', SHA2('2345',256), 20000.00, FALSE, TRUE,  'active'),
(3, 3, SHA2('5111111111111003',256), 'debit', 'mastercard', '2020-03-01', '2025-03-31', SHA2('3456',256), 50000.00, TRUE,  TRUE,  'active'),
(4, 4, SHA2('6011111111111004',256), 'debit', 'rupay',      '2023-02-10', '2028-02-29', SHA2('4567',256), 20000.00, FALSE, FALSE, 'active'),
(5, 5, SHA2('4111111111111005',256), 'debit', 'visa',       '2019-08-20', '2024-08-31', SHA2('5678',256), 30000.00, TRUE,  TRUE,  'active');

-- ===================== TRANSACTIONS (30 days) =====================
-- Generate realistic transaction data: weekdays 8-10L, weekends 13-15L, month-end +30%
-- We use stored procedure for bulk generation
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 4, 4, 'withdrawal', 8600, '2026-03-16 11:23:00', 'REF965750600', 156831, 148231, 'success', 'SES378990');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 7600, '2026-03-16 17:03:00', 'REF400733001', 190122, 182522, 'success', 'SES522903');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 9500, '2026-03-16 16:21:00', 'REF598893602', 160347, 150847, 'success', 'SES306582');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 7400, '2026-03-16 13:48:00', 'REF671232503', 116968, 109568, 'success', 'SES668780');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 5, 5, 'withdrawal', 4900, '2026-03-16 14:25:00', 'REF798520104', 180405, 175505, 'success', 'SES844818');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 4100, '2026-03-16 16:32:00', 'REF241724705', 128661, 124561, 'success', 'SES327845');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 4700, '2026-03-16 12:31:00', 'REF119403806', 126135, 121435, 'success', 'SES834950');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 6800, '2026-03-16 11:10:00', 'REF842599107', 135670, 128870, 'success', 'SES028472');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 3700, '2026-03-17 13:46:00', 'REF876592010', 193474, 189774, 'success', 'SES190954');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 2700, '2026-03-17 13:11:00', 'REF123280711', 124000, 121300, 'success', 'SES130186');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 8400, '2026-03-17 15:56:00', 'REF213796512', 216244, 207844, 'success', 'SES546140');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 9700, '2026-03-17 11:00:00', 'REF510603113', 123566, 113866, 'success', 'SES422852');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 2, 2, 'withdrawal', 2300, '2026-03-17 17:18:00', 'REF392989614', 262943, 260643, 'success', 'SES428446');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 4, 4, 'withdrawal', 9900, '2026-03-17 10:42:00', 'REF227555415', 133377, 123477, 'success', 'SES933991');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 5300, '2026-03-17 11:30:00', 'REF018858616', 195531, 190231, 'success', 'SES273206');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 4000, '2026-03-17 13:02:00', 'REF334487417', 199878, 195878, 'success', 'SES455702');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 2400, '2026-03-18 13:13:00', 'REF689686420', 182477, 180077, 'success', 'SES689873');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 4500, '2026-03-18 10:01:00', 'REF532213421', 214033, 209533, 'success', 'SES504427');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 4100, '2026-03-18 11:59:00', 'REF416162222', 167473, 163373, 'success', 'SES526551');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 8900, '2026-03-18 16:50:00', 'REF450206723', 248432, 239532, 'success', 'SES156862');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 4600, '2026-03-18 11:45:00', 'REF319529424', 174966, 170366, 'success', 'SES007478');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 6300, '2026-03-18 11:06:00', 'REF479391425', 256375, 250075, 'success', 'SES912615');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 3, 3, 'withdrawal', 9300, '2026-03-18 10:44:00', 'REF214567326', 143723, 134423, 'success', 'SES821138');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 8600, '2026-03-19 14:02:00', 'REF550761630', 201278, 192678, 'success', 'SES151301');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 7600, '2026-03-19 17:18:00', 'REF588627431', 136070, 128470, 'success', 'SES116711');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 5300, '2026-03-19 10:48:00', 'REF687445832', 197872, 192572, 'success', 'SES491757');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 7000, '2026-03-19 17:52:00', 'REF590604233', 174407, 167407, 'success', 'SES134089');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 2, 2, 'withdrawal', 6600, '2026-03-19 14:06:00', 'REF192245334', 254003, 247403, 'success', 'SES521260');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 2, 2, 'withdrawal', 2100, '2026-03-19 10:09:00', 'REF511338935', 108508, 106408, 'success', 'SES042157');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 6200, '2026-03-19 12:18:00', 'REF315826336', 203624, 197424, 'success', 'SES303085');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 2100, '2026-03-20 13:06:00', 'REF443138740', 134753, 132653, 'success', 'SES657237');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 6600, '2026-03-20 16:26:00', 'REF084767341', 194960, 188360, 'success', 'SES765180');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 4300, '2026-03-20 10:41:00', 'REF269445342', 196026, 191726, 'success', 'SES927016');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 2700, '2026-03-20 12:48:00', 'REF434057243', 132128, 129428, 'success', 'SES020633');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 4200, '2026-03-20 10:43:00', 'REF040425444', 135368, 131168, 'success', 'SES235649');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 10000, '2026-03-21 15:27:00', 'REF190299650', 155339, 145339, 'success', 'SES997094');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 20);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 2600, '2026-03-21 17:36:00', 'REF562544951', 179440, 176840, 'success', 'SES343616');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 8400, '2026-03-21 10:27:00', 'REF550900752', 254644, 246244, 'success', 'SES786636');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 5200, '2026-03-21 17:34:00', 'REF808621953', 274708, 269508, 'success', 'SES700162');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 9200, '2026-03-21 13:57:00', 'REF548438154', 232570, 223370, 'success', 'SES257881');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 10000, '2026-03-21 10:19:00', 'REF941328455', 289228, 279228, 'success', 'SES572362');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 20);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 2300, '2026-03-21 12:11:00', 'REF190418756', 129502, 127202, 'success', 'SES586978');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 9000, '2026-03-21 17:19:00', 'REF405871057', 224027, 215027, 'success', 'SES297512');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 7200, '2026-03-22 10:23:00', 'REF405190660', 250916, 243716, 'success', 'SES227998');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 4000, '2026-03-22 10:23:00', 'REF230702361', 141345, 137345, 'success', 'SES060742');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 2400, '2026-03-22 11:17:00', 'REF119619462', 240381, 237981, 'success', 'SES171729');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 3, 3, 'withdrawal', 9900, '2026-03-22 10:25:00', 'REF758519363', 137891, 127991, 'success', 'SES538307');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 8000, '2026-03-22 12:19:00', 'REF798367664', 257714, 249714, 'success', 'SES023060');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 7900, '2026-03-22 15:55:00', 'REF307868365', 107404, 99504, 'success', 'SES297658');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 3700, '2026-03-22 17:45:00', 'REF326223066', 164423, 160723, 'success', 'SES238086');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 9100, '2026-03-22 14:05:00', 'REF631377867', 142296, 133196, 'success', 'SES383842');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 7400, '2026-03-22 16:10:00', 'REF108392168', 265470, 258070, 'success', 'SES655474');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 9400, '2026-03-22 15:46:00', 'REF310379769', 133121, 123721, 'success', 'SES568007');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 9800, '2026-03-23 15:13:00', 'REF948800370', 118783, 108983, 'success', 'SES871371');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 5100, '2026-03-23 15:07:00', 'REF802583471', 124637, 119537, 'success', 'SES257451');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 7200, '2026-03-23 17:33:00', 'REF592080472', 135893, 128693, 'success', 'SES457185');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 4, 4, 'withdrawal', 5100, '2026-03-23 12:09:00', 'REF602607273', 270949, 265849, 'success', 'SES667513');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 9900, '2026-03-23 10:58:00', 'REF651596774', 119747, 109847, 'success', 'SES176730');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 7200, '2026-03-24 13:59:00', 'REF401199180', 191505, 184305, 'success', 'SES073527');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 3800, '2026-03-24 15:50:00', 'REF405779481', 225828, 222028, 'success', 'SES179195');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 5700, '2026-03-24 15:28:00', 'REF700149982', 133323, 127623, 'success', 'SES912968');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 1, 1, 'withdrawal', 3700, '2026-03-24 15:23:00', 'REF069064983', 222377, 218677, 'success', 'SES251180');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 2, 2, 'withdrawal', 3200, '2026-03-24 11:40:00', 'REF822733784', 112548, 109348, 'success', 'SES094511');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 5300, '2026-03-24 16:21:00', 'REF551039985', 178539, 173239, 'success', 'SES190886');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 7500, '2026-03-25 12:19:00', 'REF573208190', 280949, 273449, 'success', 'SES034720');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 7400, '2026-03-25 13:28:00', 'REF785032791', 277098, 269698, 'success', 'SES682014');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 8600, '2026-03-25 14:18:00', 'REF019545992', 165365, 156765, 'success', 'SES875016');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 8900, '2026-03-25 15:58:00', 'REF452914993', 288841, 279941, 'success', 'SES317102');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 2100, '2026-03-25 13:37:00', 'REF338144694', 199093, 196993, 'success', 'SES621318');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 5900, '2026-03-25 12:35:00', 'REF914414995', 289914, 284014, 'success', 'SES159031');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 2800, '2026-03-25 16:03:00', 'REF069079896', 244418, 241618, 'success', 'SES163119');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 4, 4, 'withdrawal', 5200, '2026-03-25 10:31:00', 'REF759725297', 188777, 183577, 'success', 'SES091541');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 4200, '2026-03-26 12:04:00', 'REF3030030100', 294137, 289937, 'success', 'SES453074');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 5, 5, 'withdrawal', 6400, '2026-03-26 10:57:00', 'REF7695208101', 135939, 129539, 'success', 'SES210861');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 5300, '2026-03-26 12:08:00', 'REF6910355102', 270312, 265012, 'success', 'SES271405');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 4800, '2026-03-26 12:52:00', 'REF8492872103', 143076, 138276, 'success', 'SES486733');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 4500, '2026-03-26 12:12:00', 'REF7728214104', 256369, 251869, 'success', 'SES460175');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 2800, '2026-03-26 10:58:00', 'REF4244615105', 268654, 265854, 'success', 'SES102157');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 5800, '2026-03-27 16:05:00', 'REF6072032110', 270328, 264528, 'success', 'SES322702');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 4100, '2026-03-27 14:27:00', 'REF3384121111', 160274, 156174, 'success', 'SES019094');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 2000, '2026-03-27 15:56:00', 'REF2123502112', 177051, 175051, 'success', 'SES904341');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 1, 1, 'withdrawal', 9900, '2026-03-27 11:35:00', 'REF9543505113', 228132, 218232, 'success', 'SES876890');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 6200, '2026-03-27 15:48:00', 'REF1589610114', 152053, 145853, 'success', 'SES398172');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 5, 5, 'withdrawal', 3300, '2026-03-27 10:35:00', 'REF0384577115', 262921, 259621, 'success', 'SES521379');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 4700, '2026-03-28 10:30:00', 'REF6836994120', 109821, 105121, 'success', 'SES177443');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 6400, '2026-03-28 14:26:00', 'REF1219519121', 116326, 109926, 'success', 'SES768191');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 7000, '2026-03-28 10:25:00', 'REF3676042122', 215745, 208745, 'success', 'SES765868');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 2200, '2026-03-28 12:41:00', 'REF0653132123', 277968, 275768, 'success', 'SES438806');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 2700, '2026-03-28 10:31:00', 'REF1349309124', 119803, 117103, 'success', 'SES467981');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 4800, '2026-03-28 14:41:00', 'REF3428034125', 126600, 121800, 'success', 'SES818666');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 9300, '2026-03-28 13:13:00', 'REF4337757126', 214278, 204978, 'success', 'SES921745');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 9000, '2026-03-28 13:35:00', 'REF5198188127', 285235, 276235, 'success', 'SES486114');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 10000, '2026-03-28 11:46:00', 'REF2668686128', 291961, 281961, 'success', 'SES854056');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 20);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 6600, '2026-03-28 14:11:00', 'REF8427589129', 248745, 242145, 'success', 'SES235021');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 9100, '2026-03-28 13:27:00', 'REF58510681210', 172739, 163639, 'success', 'SES878870');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 4, 4, 'withdrawal', 7700, '2026-03-28 17:13:00', 'REF85262171211', 287501, 279801, 'success', 'SES155872');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 3600, '2026-03-28 12:15:00', 'REF24390441212', 259433, 255833, 'success', 'SES420527');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 8000, '2026-03-28 13:25:00', 'REF58212801213', 158894, 150894, 'success', 'SES805754');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 3000, '2026-03-28 14:57:00', 'REF65792671214', 220087, 217087, 'success', 'SES206170');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 2800, '2026-03-29 17:10:00', 'REF1948111130', 162545, 159745, 'success', 'SES018454');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 3900, '2026-03-29 16:55:00', 'REF4948423131', 183497, 179597, 'success', 'SES212684');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 4500, '2026-03-29 12:25:00', 'REF9477879132', 147056, 142556, 'success', 'SES861800');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 2300, '2026-03-29 12:25:00', 'REF0722611133', 234525, 232225, 'success', 'SES080069');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 6800, '2026-03-29 12:43:00', 'REF2378838134', 276846, 270046, 'success', 'SES902152');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 2700, '2026-03-29 12:19:00', 'REF1736066135', 264592, 261892, 'success', 'SES748182');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 5100, '2026-03-29 14:50:00', 'REF7010722136', 131137, 126037, 'success', 'SES444090');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 6500, '2026-03-29 10:00:00', 'REF9773577137', 214862, 208362, 'success', 'SES795045');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 6100, '2026-03-29 15:57:00', 'REF9479567138', 256349, 250249, 'success', 'SES591675');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 9100, '2026-03-29 16:10:00', 'REF7928256139', 251817, 242717, 'success', 'SES646425');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 9000, '2026-03-29 13:39:00', 'REF60493631310', 159739, 150739, 'success', 'SES227845');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 3500, '2026-03-29 13:32:00', 'REF82210001311', 297720, 294220, 'success', 'SES053214');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 7000, '2026-03-29 11:29:00', 'REF32356511312', 226216, 219216, 'success', 'SES034034');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 7900, '2026-03-29 11:57:00', 'REF55550211313', 192702, 184802, 'success', 'SES686622');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 9600, '2026-03-30 17:26:00', 'REF5869751140', 269583, 259983, 'success', 'SES950170');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 6300, '2026-03-30 10:57:00', 'REF8130030141', 226471, 220171, 'success', 'SES036248');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 9500, '2026-03-30 12:30:00', 'REF5109286142', 211568, 202068, 'success', 'SES004082');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 2800, '2026-03-30 17:25:00', 'REF2228431143', 279235, 276435, 'success', 'SES197072');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 9200, '2026-03-30 15:01:00', 'REF9877435144', 173613, 164413, 'success', 'SES453215');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 7300, '2026-03-30 15:38:00', 'REF8986721145', 251707, 244407, 'success', 'SES222828');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 4, 4, 'withdrawal', 2900, '2026-03-30 14:39:00', 'REF5029469146', 108788, 105888, 'success', 'SES782513');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 4600, '2026-03-30 10:18:00', 'REF3773695147', 155247, 150647, 'success', 'SES747356');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 2200, '2026-03-31 12:51:00', 'REF3696046150', 130350, 128150, 'success', 'SES178133');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 3200, '2026-03-31 12:23:00', 'REF6518733151', 136519, 133319, 'success', 'SES941525');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 4, 4, 'withdrawal', 2100, '2026-03-31 17:02:00', 'REF6141313152', 222439, 220339, 'success', 'SES254445');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 6200, '2026-03-31 14:17:00', 'REF4803236153', 200913, 194713, 'success', 'SES765138');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 6200, '2026-03-31 10:57:00', 'REF1987547154', 107875, 101675, 'success', 'SES841258');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 7700, '2026-03-31 14:38:00', 'REF6015813155', 220037, 212337, 'success', 'SES919062');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 4500, '2026-03-31 17:29:00', 'REF2196943156', 203020, 198520, 'success', 'SES685593');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 9300, '2026-03-31 17:57:00', 'REF2656200157', 195152, 185852, 'success', 'SES025268');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 6600, '2026-03-31 13:44:00', 'REF6725078158', 139508, 132908, 'success', 'SES422250');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 8000, '2026-03-31 17:45:00', 'REF6125760159', 232877, 224877, 'success', 'SES704904');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 6000, '2026-04-01 16:34:00', 'REF3427339160', 265043, 259043, 'success', 'SES945195');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 5000, '2026-04-01 14:10:00', 'REF6066849161', 287637, 282637, 'success', 'SES921366');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 9500, '2026-04-01 13:43:00', 'REF4179635162', 226374, 216874, 'success', 'SES536360');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 8800, '2026-04-01 17:17:00', 'REF7681392163', 236123, 227323, 'success', 'SES467004');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 7100, '2026-04-01 12:30:00', 'REF8883738164', 138697, 131597, 'success', 'SES634358');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 6100, '2026-04-01 14:29:00', 'REF0772178165', 298520, 292420, 'success', 'SES196474');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 3500, '2026-04-01 16:21:00', 'REF4579150166', 239573, 236073, 'success', 'SES574873');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 7700, '2026-04-01 12:53:00', 'REF6489649167', 116798, 109098, 'success', 'SES082928');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 3100, '2026-04-02 17:09:00', 'REF5650029170', 178721, 175621, 'success', 'SES749887');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 2, 2, 'withdrawal', 6000, '2026-04-02 15:30:00', 'REF8846344171', 108073, 102073, 'success', 'SES134094');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 5, 5, 'withdrawal', 8300, '2026-04-02 11:54:00', 'REF5990783172', 200615, 192315, 'success', 'SES472660');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 6200, '2026-04-02 12:24:00', 'REF1994269173', 191038, 184838, 'success', 'SES795439');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 3100, '2026-04-02 17:24:00', 'REF0207984174', 256300, 253200, 'success', 'SES108605');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 6900, '2026-04-02 14:24:00', 'REF9713196175', 229500, 222600, 'success', 'SES504176');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 5400, '2026-04-02 16:42:00', 'REF3282678176', 235206, 229806, 'success', 'SES832941');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 9100, '2026-04-03 16:12:00', 'REF0378767180', 161488, 152388, 'success', 'SES018441');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 8400, '2026-04-03 17:27:00', 'REF0717402181', 268749, 260349, 'success', 'SES460739');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 8300, '2026-04-03 15:58:00', 'REF0332415182', 151492, 143192, 'success', 'SES533447');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 8000, '2026-04-03 16:19:00', 'REF1703689183', 232063, 224063, 'success', 'SES459012');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 7300, '2026-04-03 16:41:00', 'REF2682666184', 238227, 230927, 'success', 'SES128999');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 9800, '2026-04-03 12:32:00', 'REF6873583185', 151012, 141212, 'success', 'SES662507');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 4300, '2026-04-04 17:20:00', 'REF2060841190', 169999, 165699, 'success', 'SES050036');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 3900, '2026-04-04 12:22:00', 'REF4598574191', 197899, 193999, 'success', 'SES257682');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 1, 1, 'withdrawal', 8800, '2026-04-04 12:09:00', 'REF0266719192', 137170, 128370, 'success', 'SES764204');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 7500, '2026-04-04 13:23:00', 'REF4006651193', 252746, 245246, 'success', 'SES438016');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 3200, '2026-04-04 17:29:00', 'REF7768187194', 112415, 109215, 'success', 'SES883056');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 3600, '2026-04-04 13:30:00', 'REF8293458195', 181954, 178354, 'success', 'SES318951');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 3000, '2026-04-04 14:05:00', 'REF7551455196', 207426, 204426, 'success', 'SES293550');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 6);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 2900, '2026-04-04 17:32:00', 'REF9614848197', 244559, 241659, 'success', 'SES480216');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 8000, '2026-04-04 11:28:00', 'REF7010108198', 267896, 259896, 'success', 'SES354342');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 9800, '2026-04-04 12:06:00', 'REF9933075199', 237767, 227967, 'success', 'SES896202');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 4, 4, 'withdrawal', 5000, '2026-04-05 13:59:00', 'REF0252932200', 246450, 241450, 'success', 'SES577007');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 6300, '2026-04-05 17:14:00', 'REF9257847201', 156225, 149925, 'success', 'SES547399');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 4, 4, 'withdrawal', 7300, '2026-04-05 16:01:00', 'REF5740499202', 130837, 123537, 'success', 'SES678795');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 10000, '2026-04-05 13:16:00', 'REF3486437203', 207111, 197111, 'success', 'SES180666');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 20);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 6700, '2026-04-05 12:32:00', 'REF5778123204', 134004, 127304, 'success', 'SES368409');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 4600, '2026-04-05 15:46:00', 'REF5601139205', 144882, 140282, 'success', 'SES392968');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 9900, '2026-04-05 13:55:00', 'REF7107604206', 297184, 287284, 'success', 'SES742795');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 2600, '2026-04-05 10:22:00', 'REF8430681207', 185652, 183052, 'success', 'SES565437');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 4100, '2026-04-05 13:51:00', 'REF1715062208', 242382, 238282, 'success', 'SES374325');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 9900, '2026-04-05 10:59:00', 'REF9498604209', 225592, 215692, 'success', 'SES555329');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 4500, '2026-04-05 15:08:00', 'REF21324382010', 252126, 247626, 'success', 'SES707986');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 6400, '2026-04-05 12:00:00', 'REF77512122011', 250705, 244305, 'success', 'SES588776');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 6000, '2026-04-06 15:59:00', 'REF7023149210', 260895, 254895, 'success', 'SES211978');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 4600, '2026-04-06 10:17:00', 'REF0831608211', 169639, 165039, 'success', 'SES274321');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 1, 1, 'withdrawal', 2400, '2026-04-06 11:32:00', 'REF3092514212', 158309, 155909, 'success', 'SES552909');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 3, 3, 'withdrawal', 6700, '2026-04-06 12:44:00', 'REF0955775213', 188980, 182280, 'success', 'SES952891');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 8200, '2026-04-06 14:25:00', 'REF4438624214', 133323, 125123, 'success', 'SES135519');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 3, 3, 'withdrawal', 5000, '2026-04-06 14:42:00', 'REF9095896215', 121589, 116589, 'success', 'SES326063');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 5800, '2026-04-07 13:38:00', 'REF2382591220', 192841, 187041, 'success', 'SES835868');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 9600, '2026-04-07 11:38:00', 'REF0926102221', 130932, 121332, 'success', 'SES393783');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 8800, '2026-04-07 11:59:00', 'REF1499296222', 260852, 252052, 'success', 'SES087940');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 4900, '2026-04-07 14:57:00', 'REF2170235223', 268397, 263497, 'success', 'SES755351');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 2, 2, 'withdrawal', 9200, '2026-04-07 16:33:00', 'REF3553590224', 269490, 260290, 'success', 'SES607090');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 9400, '2026-04-08 17:34:00', 'REF4624167230', 193592, 184192, 'success', 'SES800674');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 6900, '2026-04-08 12:28:00', 'REF9100484231', 285652, 278752, 'success', 'SES564037');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 3, 3, 'withdrawal', 8200, '2026-04-08 12:37:00', 'REF2176702232', 205493, 197293, 'success', 'SES566266');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 4400, '2026-04-08 15:45:00', 'REF2757875233', 121010, 116610, 'success', 'SES577631');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 9700, '2026-04-08 15:06:00', 'REF0733788234', 296235, 286535, 'success', 'SES841092');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 3900, '2026-04-08 11:31:00', 'REF1833962235', 156524, 152624, 'success', 'SES125683');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 8000, '2026-04-08 16:10:00', 'REF2997314236', 292624, 284624, 'success', 'SES892121');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 9200, '2026-04-08 11:32:00', 'REF2624721237', 189188, 179988, 'success', 'SES727230');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 9100, '2026-04-09 17:17:00', 'REF9439551240', 233204, 224104, 'success', 'SES432743');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 18);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 3900, '2026-04-09 12:40:00', 'REF8587776241', 128294, 124394, 'success', 'SES333057');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 1, 1, 'withdrawal', 6900, '2026-04-09 13:12:00', 'REF3631639242', 166225, 159325, 'success', 'SES498546');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 7600, '2026-04-09 11:50:00', 'REF9762062243', 180107, 172507, 'success', 'SES614388');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 2500, '2026-04-09 14:59:00', 'REF4939136244', 123677, 121177, 'success', 'SES866977');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 6700, '2026-04-09 14:09:00', 'REF4904315245', 167434, 160734, 'success', 'SES080516');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 7800, '2026-04-09 12:20:00', 'REF1201337246', 172215, 164415, 'success', 'SES513561');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 10000, '2026-04-10 13:26:00', 'REF5034373250', 247143, 237143, 'success', 'SES472521');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 20);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 3, 3, 'withdrawal', 8300, '2026-04-10 10:56:00', 'REF2821844251', 186871, 178571, 'success', 'SES061363');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 6900, '2026-04-10 15:21:00', 'REF3772589252', 150758, 143858, 'success', 'SES432399');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 2500, '2026-04-10 14:24:00', 'REF4838720253', 195709, 193209, 'success', 'SES567482');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 5);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 5, 5, 'withdrawal', 4600, '2026-04-10 10:47:00', 'REF0944212254', 108774, 104174, 'success', 'SES748916');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 5400, '2026-04-11 14:44:00', 'REF3044804260', 227106, 221706, 'success', 'SES024836');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 5, 5, 'withdrawal', 8500, '2026-04-11 11:29:00', 'REF8671789261', 283010, 274510, 'success', 'SES344888');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 7500, '2026-04-11 16:02:00', 'REF2813208262', 196872, 189372, 'success', 'SES973397');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 5900, '2026-04-11 16:47:00', 'REF6963182263', 160231, 154331, 'success', 'SES261942');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 4900, '2026-04-11 14:28:00', 'REF5046066264', 285336, 280436, 'success', 'SES786578');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 5, 5, 'withdrawal', 5000, '2026-04-11 12:23:00', 'REF2659814265', 153119, 148119, 'success', 'SES499916');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 6000, '2026-04-11 10:03:00', 'REF6938948266', 264214, 258214, 'success', 'SES614003');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 12);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 5600, '2026-04-11 13:50:00', 'REF4888995267', 287778, 282178, 'success', 'SES783349');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 5800, '2026-04-11 15:15:00', 'REF0060290268', 176704, 170904, 'success', 'SES147782');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 11);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 8600, '2026-04-12 13:30:00', 'REF9193233270', 226371, 217771, 'success', 'SES688890');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 3900, '2026-04-12 17:46:00', 'REF0391967271', 258125, 254225, 'success', 'SES519294');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 2, 2, 'withdrawal', 8700, '2026-04-12 11:45:00', 'REF9054364272', 282489, 273789, 'success', 'SES155713');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 1, 1, 'withdrawal', 4900, '2026-04-12 12:48:00', 'REF0866167273', 106160, 101260, 'success', 'SES733386');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 2200, '2026-04-12 12:22:00', 'REF6458419274', 176659, 174459, 'success', 'SES783690');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 4, 4, 'withdrawal', 7100, '2026-04-12 16:34:00', 'REF3959380275', 160314, 153214, 'success', 'SES420698');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 1, 1, 'withdrawal', 3900, '2026-04-12 17:56:00', 'REF2134363276', 240059, 236159, 'success', 'SES862850');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 4, 4, 'withdrawal', 4700, '2026-04-12 12:02:00', 'REF1265285277', 116158, 111458, 'success', 'SES417071');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 8600, '2026-04-12 11:02:00', 'REF3410149278', 149497, 140897, 'success', 'SES526780');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 3700, '2026-04-12 12:16:00', 'REF6551232279', 110234, 106534, 'success', 'SES335448');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 1, 1, 'withdrawal', 7900, '2026-04-12 12:55:00', 'REF27299402710', 238204, 230304, 'success', 'SES439732');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 4, 4, 'withdrawal', 8800, '2026-04-13 14:15:00', 'REF0150704280', 147806, 139006, 'success', 'SES594164');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 9800, '2026-04-13 13:09:00', 'REF6888730281', 233885, 224085, 'success', 'SES611623');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 19);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 8500, '2026-04-13 14:33:00', 'REF4447475282', 218113, 209613, 'success', 'SES071234');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 17);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 5, 5, 'withdrawal', 8100, '2026-04-13 11:02:00', 'REF1612324283', 126208, 118108, 'success', 'SES622112');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 1, 1, 'withdrawal', 5000, '2026-04-13 10:25:00', 'REF0887033284', 285111, 280111, 'success', 'SES165145');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 10);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 4, 4, 'withdrawal', 7400, '2026-04-13 11:25:00', 'REF1926877285', 221146, 213746, 'success', 'SES756107');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 2);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (4, 2, 2, 'withdrawal', 7800, '2026-04-13 16:11:00', 'REF8747519286', 143302, 135502, 'success', 'SES722912');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 15);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 1, 1, 'withdrawal', 4800, '2026-04-13 13:11:00', 'REF0264400287', 151039, 146239, 'success', 'SES854476');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 4100, '2026-04-14 13:21:00', 'REF5418072290', 280588, 276488, 'success', 'SES745518');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 8);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (5, 4, 4, 'withdrawal', 8100, '2026-04-14 11:45:00', 'REF6465434291', 192922, 184822, 'success', 'SES958817');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (1, 2, 2, 'withdrawal', 7200, '2026-04-14 10:47:00', 'REF9715179292', 202803, 195603, 'success', 'SES106359');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 14);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 5, 5, 'withdrawal', 6600, '2026-04-14 14:42:00', 'REF4432825293', 129800, 123200, 'success', 'SES125746');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 13);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (3, 3, 3, 'withdrawal', 2200, '2026-04-14 15:18:00', 'REF4440007294', 218787, 216587, 'success', 'SES241884');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 4);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 4700, '2026-04-14 14:23:00', 'REF4579223295', 172551, 167851, 'success', 'SES970676');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 9);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 2, 2, 'withdrawal', 8200, '2026-04-14 17:01:00', 'REF7306322296', 160684, 152484, 'success', 'SES893723');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 16);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, 1);
INSERT INTO `TRANSACTION` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (2, 4, 4, 'withdrawal', 3600, '2026-04-14 14:20:00', 'REF5878849297', 276388, 272788, 'success', 'SES043384');
SET @last_txn_id = LAST_INSERT_ID();
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, 7);
INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, 1);


-- ===================== CIT_VENDOR =====================
INSERT INTO CIT_VENDOR (vendor_name, contact_person, phone, email, license_number, contract_start, contract_end, status) VALUES
("Brink's India Pvt. Ltd.",  'Sunil Agarwal', '1800-102-1010', 'ops@brinksindia.com',  'CIT-MH-2021-001', '2021-04-01', '2026-03-31', 'active'),
('Loomis Cash Management India', 'Prashant Rao', '1800-102-2020', 'india@loomis.com', 'CIT-MH-2022-007', '2022-01-01', '2026-12-31', 'active');

-- ===================== CASH_REPLENISHMENT =====================
INSERT INTO CASH_REPLENISHMENT (atm_id, vendor_id, requested_by, approved_by, request_date, scheduled_date, total_amount, status, notes) VALUES
(3, 1, 4, NULL,  NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY),  1100000.00, 'pending',  'Low cash alert triggered. Urgent replenishment needed for Pune branch ATM.'),
(4, 2, 7, NULL,  DATE_SUB(NOW(), INTERVAL 2 HOUR), DATE_ADD(NOW(), INTERVAL 2 DAY), 1300000.00, 'pending',  'Post-maintenance refill for Delhi Connaught Place ATM.');

-- ===================== REPLENISHMENT_DETAIL =====================
INSERT INTO REPLENISHMENT_DETAIL (replenishment_id, denomination_id, notes_count, amount) VALUES
(1, 1, 1800, 900000.00),
(1, 2,  500, 100000.00),
(1, 3, 1000, 100000.00),
(2, 1, 2000, 1000000.00),
(2, 2,  600, 120000.00),
(2, 3, 1800, 180000.00);

-- ===================== ATM_MAINTENANCE =====================
INSERT INTO ATM_MAINTENANCE (atm_id, technician_id, maintenance_type, scheduled_date, actual_date, duration_minutes, issue_description, resolution, cost, status) VALUES
(4, 5, 'corrective', DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY), 240,
 'Card reader jamming causing repeated card capture incidents.',
 'Card reader module replaced. Full diagnostics run — all systems OK.',
 8500.00, 'completed'),
(2, 2, 'preventive', DATE_ADD(NOW(), INTERVAL 7 DAY), NULL, NULL,
 'Scheduled quarterly preventive maintenance.',
 NULL, 3000.00, 'scheduled');

-- ===================== ATM_ALERT =====================
INSERT INTO ATM_ALERT (atm_id, resolved_by, alert_type, severity, message, status) VALUES
(3, NULL, 'low_cash',      'critical', 'Cash level critically low at SBI Pune KP ATM. ₹500 cassette has only 180 notes remaining (below threshold of 200). Immediate replenishment required.',                    'active'),
(4, NULL, 'hardware_fault','medium',   'Card reader fault detected at SBI Pune Camp ATM. Multiple card capture incidents logged. Machine taken offline for maintenance.',                                           'active'),
(2, NULL, 'network_down',  'low',      'Intermittent network connectivity issues at SBI Mumbai Bandra ATM. Transaction success rate dropped to 87%. Monitoring in progress.',                                     'active');

-- ===================== HISTORICAL CASH_REPLENISHMENT =====================
INSERT INTO CASH_REPLENISHMENT (atm_id, vendor_id, requested_by, approved_by, request_date, scheduled_date, actual_date, total_amount, status, notes) VALUES
(1, 1, 1, 1, '2026-03-01 09:00:00', '2026-03-02 10:00:00', '2026-03-02 10:30:00', 8000000.00, 'completed', 'Routine end-of-week replenishment.'),
(2, 2, 4, 4, '2026-03-05 14:00:00', '2026-03-06 11:00:00', '2026-03-06 11:45:00', 5000000.00, 'completed', 'Emergency replenishment due to high weekend volume.'),
(5, 2, 7, 7, '2026-03-10 08:30:00', '2026-03-11 09:30:00', '2026-03-11 09:50:00', 10000000.00, 'completed', 'Standard monthly refill.'),
(1, 1, 1, 1, '2026-03-15 10:15:00', '2026-03-16 12:00:00', '2026-03-16 12:20:00', 6000000.00, 'completed', 'Mid-month replenishment.'),
(3, 1, 4, 4, '2026-03-20 16:45:00', '2026-03-21 14:00:00', '2026-03-21 14:15:00', 8500000.00, 'completed', 'Pre-holiday replenishment.'),
(4, 2, 7, 7, '2026-03-25 09:20:00', '2026-03-26 10:30:00', '2026-03-26 11:00:00', 7000000.00, 'completed', 'Routine replenishment.');

-- ===================== HISTORICAL REPLENISHMENT_DETAIL =====================
INSERT INTO REPLENISHMENT_DETAIL (replenishment_id, denomination_id, notes_count, amount) VALUES
(3, 1, 10000, 5000000.00), (3, 2, 5000, 1000000.00), (3, 3, 15000, 1500000.00), (3, 4, 10000, 500000.00),
(4, 1, 6000, 3000000.00), (4, 2, 4000, 800000.00), (4, 3, 10000, 1000000.00), (4, 4, 4000, 200000.00),
(5, 1, 14000, 7000000.00), (5, 2, 5000, 1000000.00), (5, 3, 15000, 1500000.00), (5, 4, 10000, 500000.00),
(6, 1, 7000, 3500000.00), (6, 2, 3000, 600000.00), (6, 3, 10000, 1000000.00), (6, 4, 18000, 900000.00),
(7, 1, 10000, 5000000.00), (7, 2, 4000, 800000.00), (7, 3, 20000, 2000000.00), (7, 4, 14000, 700000.00),
(8, 1, 8000, 4000000.00), (8, 2, 6000, 1200000.00), (8, 3, 15000, 1500000.00), (8, 4, 6000, 300000.00);

-- ===================== HISTORICAL ATM_MAINTENANCE =====================
INSERT INTO ATM_MAINTENANCE (atm_id, technician_id, maintenance_type, scheduled_date, actual_date, duration_minutes, issue_description, resolution, cost, status) VALUES
(1, 2, 'preventive', '2026-02-10 10:00:00', '2026-02-10 10:30:00', 120, 'Monthly preventive maintenance.', 'All modules tested and cleaned. Receipt paper replaced.', 2500.00, 'completed'),
(3, 5, 'corrective', '2026-02-15 14:00:00', '2026-02-15 15:00:00', 90, 'Cash dispenser jam reported by branch.', 'Dispenser path cleared. Extravagant dust removed from sensor.', 4000.00, 'completed'),
(5, 8, 'preventive', '2026-03-01 09:30:00', '2026-03-01 10:00:00', 180, 'Quarterly comprehensive service.', 'Software updated to v4.2.1. Hard drive defragmented.', 3500.00, 'completed'),
(2, 2, 'emergency', '2026-03-12 18:00:00', '2026-03-12 18:45:00', 150, 'ATM screen frozen and unresponsive.', 'Operating system rebooted. Faulty RAM module replaced.', 12000.00, 'completed'),
(1, 5, 'preventive', '2026-03-25 11:00:00', '2026-03-25 11:30:00', 100, 'Bi-monthly cleaning and inspection.', 'Routine cleaning. Cash paths verified clear.', 2000.00, 'completed');

-- ===================== HISTORICAL ATM_ALERT =====================
INSERT INTO ATM_ALERT (atm_id, resolved_by, alert_type, severity, message, created_at, resolved_at, status) VALUES
(1, 2, 'low_cash', 'high', 'Cash level below 15% capacity in ATM 1.', '2026-02-28 14:22:00', '2026-03-02 11:00:00', 'resolved'),
(3, 5, 'hardware_fault', 'critical', 'Cash dispenser jam detected during transaction.', '2026-02-15 13:45:00', '2026-02-15 16:30:00', 'resolved'),
(5, 8, 'network_down', 'medium', 'Loss of connection to host server for 5 minutes.', '2026-03-08 02:15:00', '2026-03-08 02:30:00', 'resolved'),
(2, 2, 'vandalism', 'critical', 'Shock sensor triggered on ATM fascia.', '2026-03-12 23:45:00', '2026-03-13 01:15:00', 'resolved'),
(4, 8, 'low_cash', 'low', 'Cash level approaching 20% in cassette 3.', '2026-03-24 16:10:00', '2026-03-26 11:30:00', 'resolved');

-- ===================== AUDIT_LOG =====================
INSERT INTO AUDIT_LOG (entity_type, entity_id, action, changed_by, changed_at, old_values, new_values) VALUES
('ATM', 1, 'insert', 1, '2025-01-15 10:00:00', NULL, '{"serial_number": "SBI-ATM-MUM-001"}'),
('ATM', 2, 'insert', 1, '2025-02-20 11:30:00', NULL, '{"serial_number": "SBI-ATM-MUM-002"}'),
('CUSTOMER', 1, 'update', 4, '2025-06-12 14:15:00', '{"kyc_status": "pending"}', '{"kyc_status": "verified"}'),
('CUSTOMER', 2, 'update', 4, '2025-07-25 09:40:00', '{"kyc_status": "pending"}', '{"kyc_status": "verified"}'),
('EMPLOYEE', 5, 'update', 1, '2025-08-10 16:00:00', '{"role": "cashier"}', '{"role": "technician"}'),
('ATM_CASSETTE', 3, 'update', 2, '2026-02-15 16:45:00', '{"status": "fault"}', '{"status": "active"}'),
('CASH_REPLENISHMENT', 3, 'insert', 1, '2026-03-01 09:05:00', NULL, '{"total_amount": 8000000.00}');
