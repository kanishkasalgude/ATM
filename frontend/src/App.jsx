import { useState, useEffect } from 'react';
import { BrowserRouter, Routes, Route, Outlet } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Header  from './components/Header';
import Dashboard          from './pages/Dashboard';
import ATMManagement      from './pages/ATMManagement';
import Transactions       from './pages/Transactions';
import Replenishment      from './pages/Replenishment';
import Analytics          from './pages/Analytics';
import ComparativeAnalysis from './pages/ComparativeAnalysis';
import AlertsAudit        from './pages/AlertsAudit';
import MasterData         from './pages/MasterData';
import api from './api/client';

function Layout({ alertCount }) {
  const [collapsed, setCollapsed] = useState(false);
  return (
    <div className="flex min-h-screen">
      <Sidebar collapsed={collapsed} setCollapsed={setCollapsed} />
      <div className="flex-1 flex flex-col min-w-0">
        <Header alertCount={alertCount} />
        <main className="flex-1 p-6 overflow-auto">
          <Outlet />
        </main>
      </div>
    </div>
  );
}

export default function App() {
  const [alertCount, setAlertCount] = useState(0);

  useEffect(() => {
    api.get('/alerts').then(r => {
      setAlertCount(r.data.filter(a => a.status === 'active').length);
    }).catch(() => {});
  }, []);

  return (
    <BrowserRouter>
      <Routes>
        <Route element={<Layout alertCount={alertCount} />}>
          <Route path="/"              element={<Dashboard />} />
          <Route path="/atms"          element={<ATMManagement />} />
          <Route path="/transactions"  element={<Transactions />} />
          <Route path="/replenishment" element={<Replenishment />} />
          <Route path="/analytics"     element={<Analytics />} />
          <Route path="/comparative"   element={<ComparativeAnalysis />} />
          <Route path="/alerts"        element={<AlertsAudit />} />
          <Route path="/master"        element={<MasterData />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
