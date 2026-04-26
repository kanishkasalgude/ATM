# ATM Cash Management System

A full-stack ATM cash logistics and monitoring platform designed to manage cash flow, track transactions, and optimize replenishment operations across a banking network. The system is built with a strong focus on database design, entity relationships, and analytical modeling using discrete mathematics.

---

## 1. System Overview

The ATM Cash Management System provides a centralized platform for banks to monitor ATM operations, manage cash inventory, and coordinate replenishment activities. It integrates core banking entities with ATM infrastructure to ensure efficient, secure, and scalable operations.

The system models real-world banking workflows, including customer transactions, ATM cash handling, vendor coordination, and system monitoring. It is designed to minimize downtime, prevent cash-out scenarios, and improve operational decision-making through structured data management.

---

## 2. Objectives

- Ensure continuous availability of cash in ATMs  
- Maintain accurate tracking of denomination-wise cash distribution  
- Provide real-time visibility into ATM status and performance  
- Optimize replenishment scheduling and logistics  
- Maintain auditability and security across all operations  

---

## 3. Key Functional Modules

### 3.1 ATM Monitoring
Tracks ATM status, cash levels, and operational health. Each ATM is associated with a branch and maintains metadata such as location, capacity, and status.

### 3.2 Transaction Management
Handles all ATM-based transactions, including withdrawals. Each transaction records:
- Account and card linkage  
- Timestamp and amount  
- Pre- and post-balance  
- Status and failure reasons  

### 3.3 Cash and Denomination Management
Manages physical cash inside ATMs using cassette-based storage:
- Each ATM contains multiple cassettes  
- Each cassette stores a specific denomination  
- Tracks capacity, current count, and thresholds  

### 3.4 Replenishment System
Implements a workflow for cash refilling:
- Request → Approval → Execution  
- Managed by employees and fulfilled by CIT vendors  
- Tracks denomination-wise replenishment details  

### 3.5 Maintenance and Alerts
- Logs ATM faults and maintenance operations  
- Generates alerts for low cash, failures, or anomalies  
- Tracks resolution by authorized personnel  

### 3.6 Audit Logging
Maintains a complete audit trail of all critical operations:
- Entity changes  
- User actions  
- Before/after state tracking  

---

## 4. Database Design and ER Model

The system is built on a relational database consisting of 17 interconnected tables. The schema is designed to enforce data integrity using primary and foreign key constraints, ensuring consistency across all operations.

### Core Entity Groups

**Banking Structure**
- BANK  
- BRANCH  
- EMPLOYEE  

**Customer Management**
- CUSTOMER  
- ACCOUNT  
- CARD  

**ATM Infrastructure**
- ATM  
- ATM_CASSETTE  
- DENOMINATION  

**Transaction System**
- TRANSACTION  
- TXN_DENOMINATION  

**Cash Operations**
- CASH_REPLENISHMENT  
- REPLENISHMENT_DETAIL  
- CIT_VENDOR  

**Monitoring and Control**
- ATM_MAINTENANCE  
- ATM_ALERT  
- AUDIT_LOG  

### Relationship Highlights

- A bank manages multiple branches  
- Each branch operates multiple ATMs and accounts  
- Customers own accounts and associated cards  
- Transactions are linked to ATMs, accounts, and cards  
- ATMs store cash through denomination-based cassettes  
- Replenishment operations involve vendors and employees  
- Alerts and maintenance records are tied to ATMs  

This structured ER model ensures normalization, reduces redundancy, and supports scalable query operations.

---

## 5. Analytical and Optimization Components

The system incorporates discrete mathematics models to improve operational efficiency:

- **Demand Forecasting** using moving averages  
- **Safety Cash Estimation** to prevent shortages  
- **Cash Flow Simulation** for predicting balances  
- **Cost Optimization** for minimizing replenishment and holding costs  

---

## 6. Technology Stack

### Frontend
- React (Vite)  
- Tailwind CSS  
- Recharts  

### Backend
- Node.js  
- Express.js  

### Database
- MySQL 8.0  

---

## 7. System Architecture

The application follows a layered architecture:

- **Presentation Layer**: User interface for dashboards and analytics  
- **Application Layer**: RESTful APIs handling business logic  
- **Data Layer**: Relational database with normalized schema  

This separation ensures maintainability, scalability, and modular development.

---

## 8. Setup Instructions

### Prerequisites
- Node.js (v18 or higher)  
- MySQL (v8.0 or higher)  

### Database Initialization
```bash
mysql -u root -p < backend/db/schema.sql
mysql -u root -p atm_cash_mgmt < backend/db/seed.sql
