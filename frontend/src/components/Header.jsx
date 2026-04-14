import { useLocation } from 'react-router-dom';
import { Bell, User, RefreshCcw } from 'lucide-react';

const titles = {
  '/':              { title: 'Dashboard',            sub: 'Overview of ATM network performance' },
  '/atms':          { title: 'ATM Management',       sub: 'Monitor and manage all ATMs' },
  '/transactions':  { title: 'Transactions',         sub: 'Transaction logs and analytics' },
  '/replenishment': { title: 'Cash Replenishment',   sub: 'Manage cash replenishment requests' },
  '/analytics':     { title: 'Analytics & Forecasting', sub: 'Discrete Mathematics models for cash optimization' },
  '/comparative':   { title: 'Comparative Analysis', sub: 'ATM cash management strategy comparison' },
  '/alerts':        { title: 'Alerts & Audit Log',   sub: 'Active alerts and system audit trail' },
  '/master':        { title: 'Master Data',          sub: 'Manage reference data' },
};

export default function Header({ alertCount }) {
  const { pathname } = useLocation();
  const info = titles[pathname] || { title: 'ATM System', sub: '' };

  return (
    <header className="bg-white border-b border-gray-100 px-6 py-4 flex items-center justify-between shadow-sm sticky top-0 z-30">
      <div>
        <h1 className="text-lg font-bold text-navy">{info.title}</h1>
        <p className="text-xs text-gray-500">{info.sub}</p>
      </div>

      <div className="flex items-center gap-3">
        {/* Date */}
        <span className="text-xs text-gray-400 hidden md:block">
          {new Date().toLocaleDateString('en-IN', { day:'numeric', month:'long', year:'numeric' })}
        </span>

        {/* Alert bell */}
        <div className="relative">
          <button className="w-9 h-9 rounded-lg border border-gray-100 flex items-center justify-center text-gray-500 hover:bg-orange-50 hover:text-orange transition-colors">
            <Bell size={17} />
          </button>
          {alertCount > 0 && (
            <span className="absolute -top-1 -right-1 w-4 h-4 bg-red-500 text-white text-xs rounded-full flex items-center justify-center font-bold">
              {alertCount}
            </span>
          )}
        </div>

        {/* User */}
        <div className="flex items-center gap-2 bg-navy-50 px-3 py-1.5 rounded-lg">
          <div className="w-6 h-6 rounded-full bg-navy flex items-center justify-center">
            <User size={14} className="text-white" />
          </div>
          <span className="text-xs font-semibold text-navy hidden sm:block">Admin</span>
        </div>
      </div>
    </header>
  );
}
