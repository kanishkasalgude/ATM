-- =============================================================
-- ATM Cash Management System — MySQL Schema (17 Tables)
-- PICT Pune Mini Project | DBMS + Discrete Mathematics
-- =============================================================

CREATE DATABASE IF NOT EXISTS atm_cash_mgmt;
USE atm_cash_mgmt;

-- 1. BANK
CREATE TABLE IF NOT EXISTS BANK (
    bank_id       INT AUTO_INCREMENT PRIMARY KEY,
    bank_name     VARCHAR(100) NOT NULL,
    swift_code    VARCHAR(20)  NOT NULL UNIQUE,
    headquarters  VARCHAR(200),
    phone         VARCHAR(20),
    established_date DATE,
    status        ENUM('active','inactive') DEFAULT 'active'
);

-- 2. EMPLOYEE (declared before BRANCH for FK reference)
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    employee_id  INT AUTO_INCREMENT PRIMARY KEY,
    branch_id    INT,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email        VARCHAR(100) UNIQUE,
    phone        VARCHAR(20),
    role         ENUM('manager','technician','cashier','admin') NOT NULL,
    hire_date    DATE,
    status       ENUM('active','inactive') DEFAULT 'active'
);

-- 3. BRANCH
CREATE TABLE IF NOT EXISTS BRANCH (
    branch_id    INT AUTO_INCREMENT PRIMARY KEY,
    bank_id      INT NOT NULL,
    manager_id   INT,
    branch_name  VARCHAR(100) NOT NULL,
    ifsc_code    VARCHAR(20)  NOT NULL UNIQUE,
    address      VARCHAR(300),
    city         VARCHAR(50),
    state        VARCHAR(50),
    status       ENUM('active','inactive') DEFAULT 'active',
    FOREIGN KEY (bank_id)    REFERENCES BANK(bank_id),
    FOREIGN KEY (manager_id) REFERENCES EMPLOYEE(employee_id)
);

-- Now add branch_id FK to EMPLOYEE
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT fk_emp_branch FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id);

-- 4. ATM
CREATE TABLE IF NOT EXISTS ATM (
    atm_id            INT AUTO_INCREMENT PRIMARY KEY,
    branch_id         INT NOT NULL,
    serial_number     VARCHAR(50) UNIQUE,
    model             VARCHAR(100),
    manufacturer      VARCHAR(100),
    location_address  VARCHAR(300),
    latitude          DECIMAL(9,6),
    longitude         DECIMAL(9,6),
    atm_type          ENUM('onsite','offsite','mobile') DEFAULT 'onsite',
    installation_date DATE,
    max_capacity      INT DEFAULT 500000,
    software_version  VARCHAR(30),
    status            ENUM('active','inactive','maintenance') DEFAULT 'active',
    FOREIGN KEY (branch_id) REFERENCES BRANCH(branch_id)
);

-- 5. DENOMINATION
CREATE TABLE IF NOT EXISTS DENOMINATION (
    denomination_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_code   VARCHAR(5) DEFAULT 'INR',
    value           DECIMAL(10,2) NOT NULL,
    description     VARCHAR(100)
);

-- 6. ATM_CASSETTE
CREATE TABLE IF NOT EXISTS ATM_CASSETTE (
    cassette_id      INT AUTO_INCREMENT PRIMARY KEY,
    atm_id           INT NOT NULL,
    denomination_id  INT NOT NULL,
    cassette_slot    TINYINT NOT NULL,
    max_capacity     INT DEFAULT 2000,
    current_count    INT DEFAULT 0,
    low_threshold    INT DEFAULT 200,
    status           ENUM('active','empty','fault') DEFAULT 'active',
    FOREIGN KEY (atm_id)          REFERENCES ATM(atm_id),
    FOREIGN KEY (denomination_id) REFERENCES DENOMINATION(denomination_id)
);

-- 7. CUSTOMER
CREATE TABLE IF NOT EXISTS CUSTOMER (
    customer_id    INT AUTO_INCREMENT PRIMARY KEY,
    first_name     VARCHAR(50)  NOT NULL,
    last_name      VARCHAR(50)  NOT NULL,
    date_of_birth  DATE,
    email          VARCHAR(100) UNIQUE,
    phone          VARCHAR(20),
    aadhar_number  VARCHAR(16) UNIQUE,
    pan_number     VARCHAR(10) UNIQUE,
    kyc_status     ENUM('pending','verified','rejected') DEFAULT 'pending',
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    status         ENUM('active','inactive','blocked') DEFAULT 'active'
);

-- 8. ACCOUNT
CREATE TABLE IF NOT EXISTS ACCOUNT (
    account_id             INT AUTO_INCREMENT PRIMARY KEY,
    customer_id            INT NOT NULL,
    branch_id              INT NOT NULL,
    account_number         VARCHAR(20) UNIQUE NOT NULL,
    account_type           ENUM('savings','current','salary') DEFAULT 'savings',
    balance                DECIMAL(15,2) DEFAULT 0.00,
    daily_withdrawal_limit DECIMAL(10,2) DEFAULT 20000.00,
    opening_date           DATE,
    status                 ENUM('active','inactive','frozen') DEFAULT 'active',
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (branch_id)   REFERENCES BRANCH(branch_id)
);

-- 9. CARD
CREATE TABLE IF NOT EXISTS CARD (
    card_id                INT AUTO_INCREMENT PRIMARY KEY,
    account_id             INT NOT NULL,
    customer_id            INT NOT NULL,
    card_number_hash       VARCHAR(64),
    card_type              ENUM('debit','credit') DEFAULT 'debit',
    network                ENUM('visa','mastercard','rupay') DEFAULT 'rupay',
    issue_date             DATE,
    expiry_date            DATE,
    pin_hash               VARCHAR(64),
    daily_limit            DECIMAL(10,2) DEFAULT 20000.00,
    international_enabled  BOOLEAN DEFAULT FALSE,
    contactless_enabled    BOOLEAN DEFAULT TRUE,
    status                 ENUM('active','blocked','expired') DEFAULT 'active',
    FOREIGN KEY (account_id)  REFERENCES ACCOUNT(account_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);

-- 10. TRANSACTION
CREATE TABLE IF NOT EXISTS `TRANSACTION` (
    transaction_id   INT AUTO_INCREMENT PRIMARY KEY,
    atm_id           INT NOT NULL,
    card_id          INT,
    account_id       INT,
    transaction_type ENUM('withdrawal','balance_inquiry','mini_statement') DEFAULT 'withdrawal',
    amount           DECIMAL(12,2) DEFAULT 0.00,
    txn_datetime     DATETIME DEFAULT CURRENT_TIMESTAMP,
    reference_number VARCHAR(30) UNIQUE,
    balance_before   DECIMAL(15,2),
    balance_after    DECIMAL(15,2),
    status           ENUM('success','failed','reversed') DEFAULT 'success',
    failure_reason   VARCHAR(200),
    session_id       VARCHAR(50),
    FOREIGN KEY (atm_id)     REFERENCES ATM(atm_id),
    FOREIGN KEY (card_id)    REFERENCES CARD(card_id),
    FOREIGN KEY (account_id) REFERENCES ACCOUNT(account_id)
);

-- 11. TXN_DENOMINATION
CREATE TABLE IF NOT EXISTS TXN_DENOMINATION (
    td_id            INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id   INT NOT NULL,
    denomination_id  INT NOT NULL,
    notes_count      INT DEFAULT 0,
    FOREIGN KEY (transaction_id)  REFERENCES `TRANSACTION`(transaction_id),
    FOREIGN KEY (denomination_id) REFERENCES DENOMINATION(denomination_id)
);

-- 12. CIT_VENDOR
CREATE TABLE IF NOT EXISTS CIT_VENDOR (
    vendor_id       INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name     VARCHAR(100) NOT NULL,
    contact_person  VARCHAR(100),
    phone           VARCHAR(20),
    email           VARCHAR(100),
    license_number  VARCHAR(50),
    contract_start  DATE,
    contract_end    DATE,
    status          ENUM('active','inactive','expired') DEFAULT 'active'
);

-- 13. CASH_REPLENISHMENT
CREATE TABLE IF NOT EXISTS CASH_REPLENISHMENT (
    replenishment_id INT AUTO_INCREMENT PRIMARY KEY,
    atm_id           INT NOT NULL,
    vendor_id        INT NOT NULL,
    requested_by     INT,
    approved_by      INT,
    request_date     DATETIME DEFAULT CURRENT_TIMESTAMP,
    scheduled_date   DATETIME,
    actual_date      DATETIME,
    total_amount     DECIMAL(15,2),
    status           ENUM('pending','approved','in_transit','completed','cancelled') DEFAULT 'pending',
    notes            TEXT,
    FOREIGN KEY (atm_id)        REFERENCES ATM(atm_id),
    FOREIGN KEY (vendor_id)     REFERENCES CIT_VENDOR(vendor_id),
    FOREIGN KEY (requested_by)  REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (approved_by)   REFERENCES EMPLOYEE(employee_id)
);

-- 14. REPLENISHMENT_DETAIL
CREATE TABLE IF NOT EXISTS REPLENISHMENT_DETAIL (
    detail_id        INT AUTO_INCREMENT PRIMARY KEY,
    replenishment_id INT NOT NULL,
    denomination_id  INT NOT NULL,
    notes_count      INT DEFAULT 0,
    amount           DECIMAL(12,2) DEFAULT 0.00,
    FOREIGN KEY (replenishment_id) REFERENCES CASH_REPLENISHMENT(replenishment_id),
    FOREIGN KEY (denomination_id)  REFERENCES DENOMINATION(denomination_id)
);

-- 15. ATM_MAINTENANCE
CREATE TABLE IF NOT EXISTS ATM_MAINTENANCE (
    maintenance_id    INT AUTO_INCREMENT PRIMARY KEY,
    atm_id            INT NOT NULL,
    technician_id     INT,
    maintenance_type  ENUM('preventive','corrective','emergency') DEFAULT 'preventive',
    scheduled_date    DATETIME,
    actual_date       DATETIME,
    duration_minutes  INT,
    issue_description TEXT,
    resolution        TEXT,
    cost              DECIMAL(10,2),
    status            ENUM('scheduled','in_progress','completed','cancelled') DEFAULT 'scheduled',
    FOREIGN KEY (atm_id)        REFERENCES ATM(atm_id),
    FOREIGN KEY (technician_id) REFERENCES EMPLOYEE(employee_id)
);

-- 16. ATM_ALERT
CREATE TABLE IF NOT EXISTS ATM_ALERT (
    alert_id    INT AUTO_INCREMENT PRIMARY KEY,
    atm_id      INT NOT NULL,
    resolved_by INT,
    alert_type  ENUM('low_cash','hardware_fault','network_down','vandalism') NOT NULL,
    severity    ENUM('low','medium','high','critical') DEFAULT 'medium',
    message     TEXT,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    resolved_at DATETIME,
    status      ENUM('active','resolved','acknowledged') DEFAULT 'active',
    FOREIGN KEY (atm_id)      REFERENCES ATM(atm_id),
    FOREIGN KEY (resolved_by) REFERENCES EMPLOYEE(employee_id)
);

-- 17. AUDIT_LOG
CREATE TABLE IF NOT EXISTS AUDIT_LOG (
    log_id      INT AUTO_INCREMENT PRIMARY KEY,
    entity_type VARCHAR(50),
    entity_id   INT,
    action      ENUM('insert','update','delete') NOT NULL,
    changed_by  INT,
    changed_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_values  JSON,
    new_values  JSON
);
