import { NavLink, useLocation } from 'react-router-dom';
import {
  LayoutDashboard, Landmark, Receipt, RefreshCcw,
  BarChart3, GitCompare, Bell, Database, ChevronRight
} from 'lucide-react';

const nav = [
  { to: '/',              label: 'Dashboard',           icon: LayoutDashboard },
  { to: '/atms',          label: 'ATM Management',      icon: Landmark },
  { to: '/transactions',  label: 'Transactions',        icon: Receipt },
  { to: '/replenishment', label: 'Replenishment',       icon: RefreshCcw },
  { to: '/analytics',     label: 'Analytics',           icon: BarChart3 },
  { to: '/comparative',   label: 'Comparative Analysis',icon: GitCompare },
  { to: '/alerts',        label: 'Alerts & Audit',      icon: Bell },
  { to: '/master',        label: 'Master Data',         icon: Database },
];

export default function Sidebar({ collapsed, setCollapsed }) {
  return (
    <aside className={`${collapsed ? 'w-16' : 'w-64'} transition-all duration-300 bg-navy flex flex-col min-h-screen flex-shrink-0 shadow-2xl`}>
      {/* Logo */}
      <div className="flex items-center gap-3 px-4 py-5 border-b border-white/10">
        <div className="w-9 h-9 rounded-lg bg-orange flex items-center justify-center flex-shrink-0">
          <span className="text-white font-extrabold text-base">A</span>
        </div>
        {!collapsed && (
          <div className="min-w-0">
            <p className="text-white font-bold text-sm leading-tight truncate">ATM Cash Mgmt</p>
            <p className="text-navy-200 text-xs">PICT Pune</p>
          </div>
        )}
        <button
          onClick={() => setCollapsed(!collapsed)}
          className="ml-auto text-navy-200 hover:text-white transition-colors"
        >
          <ChevronRight size={16} className={`transition-transform ${collapsed ? '' : 'rotate-180'}`} />
        </button>
      </div>

      {/* Nav */}
      <nav className="flex-1 px-2 py-4 space-y-1 overflow-hidden">
        {nav.map(({ to, label, icon: Icon }) => (
          <NavLink
            key={to}
            to={to}
            end={to === '/'}
            className={({ isActive }) =>
              `sidebar-link ${isActive ? 'active' : ''}`
            }
            title={collapsed ? label : undefined}
          >
            <Icon size={18} className="flex-shrink-0" />
            {!collapsed && <span className="truncate">{label}</span>}
          </NavLink>
        ))}
      </nav>

      {/* Footer */}
      {!collapsed && (
        <div className="px-4 py-4 border-t border-white/10 text-navy-200 text-xs">
          <p className="font-semibold">DBMS + Discrete Maths</p>
          <p>Mini Project 2025</p>
        </div>
      )}
    </aside>
  );
}
