const express = require('express');
const cors    = require('cors');
require('dotenv').config();

const { initDB } = require('./db');
const dashboardRoutes     = require('./routes/dashboard');
const atmRoutes           = require('./routes/atms');
const transactionRoutes   = require('./routes/transactions');
const replenishmentRoutes = require('./routes/replenishments');
const analyticsRoutes     = require('./routes/analytics');
const alertRoutes         = require('./routes/alerts');
const masterDataRoutes    = require('./routes/masterdata');

const app  = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/dashboard',      dashboardRoutes);
app.use('/api/atms',           atmRoutes);
app.use('/api/transactions',   transactionRoutes);
app.use('/api/replenishments', replenishmentRoutes);
app.use('/api/analytics',      analyticsRoutes);
app.use('/api/alerts',         alertRoutes);
app.use('/api/master',         masterDataRoutes);

app.get('/', (req, res) => res.json({ message: 'ATM Cash Management API v1.0' }));

// Boot
initDB()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`🚀 ATM API running on http://localhost:${PORT}`);
    });
  })
  .catch(err => {
    console.error('Failed to initialize DB:', err);
    process.exit(1);
  });
