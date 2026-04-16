# ATM Cash Management System 🏦

A comprehensive full-stack solution designed to optimize ATM cash logistics, track real-time transactions, and minimize cash-out events. Developed targeting essential database management and discrete mathematics principles.

**Theme:** Navy Blue (`#1B2A6B`) + Orange (`#E87722`)

---

## 🎯 Project Overview

This robust platform provides banks and Cash-in-Transit (CIT) vendors with real-time insights into ATM health, cash levels, and operational bottlenecks. By applying discrete mathematics for forecasting and optimization, the system maximizes efficiency across the bank's entire endpoint network.

### ✨ Key Features
- **Real-Time Monitoring:** Live dashboard tracking ATM states and cash levels.
- **Predictive Analytics:** Forecasting algorithms based on moving averages and discrete math models to preemptively resolve shortages.
- **Automated Alerts:** Instant triggers for low cash, hardware faults, and network downtime.
- **Replenishment Workflow:** End-to-end lifecycle management of request, approval, and completion.
- **Comprehensive Data Model:** 17 interconnected MySQL tables mapping branches, ATMs, cassettes, and granular transactions.

---

## 🌿 Environmental & Sustainability Goals

The integration of smart logistics and data-driven routing directly contributes to significant environmental targets:

- **Reduced Carbon Footprint:** Optimized cash replenishment routes for CIT vendors significantly decrease fleet fuel consumption.
- **Resource Efficiency:** Precise cash forecasting minimizes unnecessary physical cash movements, lowering the overall energy required for logistics.
- **Paperless Operations:** Fully digitized approval workflows, audit tracking, and reporting reduce paper waste across administrative tasks.
- **Hardware Longevity:** Prompt notifications of hardware faults prevent cascading damage, reducing electronic waste (e-waste) and extending machine life cycles.

---

## 🛠️ Technical Architecture

### Tech Stack
- **Frontend Ecosystem:** React (Vite), Tailwind CSS to execute the color theme, and Recharts for visual analytics.
- **Backend Ecosystem:** Node.js and Express.js implementing a robust, RESTful API architecture.
- **Database Layer:** MySQL 8.0, maintaining strict data integrity and relations.

### Core Analytics Modules (Discrete Mathematics)
| Module | Description / Approach | Formula |
|:---|:---|:---|
| **Moving Average Forecasting** | Predicts short-term demand based on historic data. | `D(t+1) = Σ Dᵢ / n` |
| **Safety Cash Calculator** | Calculates buffers required to avoid outages. | `SC = Z × σ` |
| **Cash Balance Simulator** | Simulates future end-of-day balances dynamically. | `C(t+1) = C(t) − D(t) + R(t)` |
| **Optimization Engine** | Minimizes overhead, refilling, and outage penalties. | `Min TC = Refill + Holding + Shortage` |

---

## 🚀 Quick Start Guide

### Prerequisites
- **Node.js** (v18 or higher)
- **MySQL** (v8.0 or higher)

### 1. Database Setup
Initialize the base schema and populate it with seed data.
```bash
mysql -u root -p < backend/db/schema.sql
mysql -u root -p atm_cash_mgmt < backend/db/seed.sql
```

### 2. Environment Configuration
Create or modify `backend/.env`:
```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=atm_cash_mgmt
PORT=5000
```

### 3. Start the Backend Server
```bash
cd backend
npm install
node app.js
# → 🚀 ATM API running on http://localhost:5000
```

### 4. Start the Frontend Client
```bash
cd frontend
npm install
npm run dev
# → Application accessible at http://localhost:5173
```

---

## 📁 Repository Structure

```text
├── backend/
│   ├── db/                 # Schema and robust seed data (17 tables)
│   ├── routes/             # API endpoints (dashboard, atms, analytics, etc)
│   ├── app.js              # Express application entrypoint
│   └── db.js               # MySQL connection pool
└── frontend/
    ├── src/
    │   ├── pages/          # Core views (Dashboard, Analytics, Alerts, etc)
    │   └── components/     # Reusable layout and UI components
```

## 🗄️ Database Schema

The core structure relies on 17 rigorously curated tables:
![Tables] `BANK` · `BRANCH` · `EMPLOYEE` · `ATM` · `DENOMINATION` · `ATM_CASSETTE` · `CUSTOMER` · `ACCOUNT` · `CARD` · `TRANSACTION` · `TXN_DENOMINATION` · `CIT_VENDOR` · `CASH_REPLENISHMENT` · `REPLENISHMENT_DETAIL` · `ATM_MAINTENANCE` · `ATM_ALERT` · `AUDIT_LOG`

## 🌱 Included Seed Data
The repository provides extensive mock data representing operations for *State Bank of India*, including multiple branches, various ATM models (Diebold, NCR), 30 days of transactions scaled for weekends/weekdays, vendor data, and simulated system alerts.
