# ATM Cash Management System
### PICT Pune Mini Project — DBMS + Discrete Mathematics

**Color Theme:** Navy Blue `#1B2A6B` + Orange `#E87722`

---

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- MySQL 8.0+ running locally

### 1. Database Setup

Open MySQL and run:
```sql
SOURCE c:/MY/MYPROJECTS/ATM/backend/db/schema.sql;
SOURCE c:/MY/MYPROJECTS/ATM/backend/db/seed.sql;
```

Or via CLI:
```bash
mysql -u root -p < backend/db/schema.sql
mysql -u root -p atm_cash_mgmt < backend/db/seed.sql
```

### 2. Configure Environment

Edit `backend/.env`:
```
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=YOUR_MYSQL_PASSWORD   ← change this!
DB_NAME=atm_cash_mgmt
PORT=5000
```

### 3. Start Backend
```bash
cd backend
npm install       # (already done)
node app.js
# → 🚀 ATM API running on http://localhost:5000
```

### 4. Start Frontend (new terminal)
```bash
cd frontend
npm run dev
# → Open http://localhost:5173
```

---

## 📁 Project Structure

```
ATM/
├── backend/
│   ├── db/
│   │   ├── schema.sql         # 17 MySQL tables
│   │   └── seed.sql           # SBI bank, branches, ATMs, 30-day txns
│   ├── routes/
│   │   ├── dashboard.js       # KPIs, ATM grid, weekly chart, alerts
│   │   ├── atms.js            # ATM CRUD + cassette detail
│   │   ├── transactions.js    # Filtered txns, denomination breakdown, CSV export
│   │   ├── replenishments.js  # Replenishment workflow API
│   │   ├── analytics.js       # Moving average + simulation data
│   │   ├── alerts.js          # Alert resolve + audit log
│   │   └── masterdata.js      # Reference data CRUD
│   ├── db.js                  # MySQL connection pool
│   ├── app.js                 # Express server
│   └── .env                   # Database credentials
└── frontend/
    └── src/
        ├── pages/
        │   ├── Dashboard.jsx          # KPIs, chart, ATM grid, quick actions
        │   ├── ATMManagement.jsx      # Table, cassettes, Add/Edit modal
        │   ├── Transactions.jsx       # Filter, paginate, denomination expand
        │   ├── Replenishment.jsx      # Request → Approve → Complete workflow
        │   ├── Analytics.jsx          # 4 Discrete Math sub-tabs
        │   ├── ComparativeAnalysis.jsx# PPT-style table + 5 approach cards
        │   ├── AlertsAudit.jsx        # Alert cards + audit log
        │   └── MasterData.jsx         # 7 entity CRUD tabs
        └── components/
            ├── Sidebar.jsx
            └── Header.jsx
```

## 🗄️ Database Schema (17 Tables)

BANK · BRANCH · EMPLOYEE · ATM · DENOMINATION · ATM_CASSETTE ·
CUSTOMER · ACCOUNT · CARD · TRANSACTION · TXN_DENOMINATION ·
CIT_VENDOR · CASH_REPLENISHMENT · REPLENISHMENT_DETAIL ·
ATM_MAINTENANCE · ATM_ALERT · AUDIT_LOG

## 📊 Analytics Modules (Discrete Mathematics)

| Module | Formula |
|---|---|
| Moving Average Forecasting | D̂(t+1) = Σ Dᵢ / n |
| Safety Cash Calculator | SC = Z×σ; Min = μ+SC |
| Cash Balance Simulation | C(t+1) = C(t) − D(t) + R(t) |
| Optimization Engine | Minimize TC = Refill + Holding + Shortage cost |

## 🌱 Seed Data

- **Bank:** State Bank of India
- **Branches:** Mumbai Main, Pune Koregaon Park, Delhi Connaught Place
- **ATMs:** 5 ATMs (Diebold Nixdorf, NCR, Hyosung)
- **Transactions:** 30 days (weekday 8-10L, weekend 13-15L, month-end +30%)
- **Alerts:** 3 active (low_cash critical, hardware_fault medium, network_down low)
- **Vendors:** Brink's India, Loomis Cash Management
- **Employees:** 9 (3 per branch)
- **Customers:** 5 with accounts and RuPay/Visa debit cards
