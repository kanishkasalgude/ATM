import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer
} from 'recharts';
import {
  Landmark, CheckCircle, ArrowUpRight, AlertTriangle,
  Plus, Wrench, RefreshCcw, Wifi, WifiOff, Cpu
} from 'lucide-react';
import api from '../api/client';

// ─── helpers ─────────────────────────────────────────────────────────────────
const fmt = (v) => `₹${(v / 100000).toFixed(2)}L`;
const fmtDate = (d) => new Date(d).toLocaleDateString('en-IN', { day: 'numeric', month: 'short' });

const ATM_STATUS_COLOR = {
  active:      'bg-green-100 text-green-800 border border-green-300',
  inactive:    'bg-gray-100 text-gray-600 border border-gray-300',
  maintenance: 'bg-yellow-100 text-yellow-800 border border-yellow-300',
};
const ALT_COLOR = {
  critical: 'bg-red-50 border-red-400 text-red-700',
  high:     'bg-orange-50 border-orange-400 text-orange-700',
  medium:   'bg-yellow-50 border-yellow-400 text-yellow-700',
  low:      'bg-blue-50 border-blue-400 text-blue-600',
};
const ALERT_ICON = {
  low_cash:       <AlertTriangle size={16} />,
  hardware_fault: <Cpu size={16} />,
  network_down:   <WifiOff size={16} />,
  vandalism:      <AlertTriangle size={16} />,
};

// ─── Custom chart tooltip ─────────────────────────────────────────────────────
function ChartTooltip({ active, payload, label }) {
  if (!active || !payload?.length) return null;
  return (
    <div className="bg-navy text-white px-3 py-2 rounded-xl shadow-lg text-xs">
      <p className="font-semibold mb-1">{fmtDate(label)}</p>
      <p>₹{Number(payload[0].value / 100000).toFixed(2)} Lakhs</p>
      <p className="text-navy-200">{payload[0].payload.count} txns</p>
    </div>
  );
}

export default function Dashboard() {
  const [kpis,       setKpis]       = useState(null);
  const [atmGrid,    setAtmGrid]    = useState([]);
  const [chart,      setChart]      = useState([]);
  const [alerts,     setAlerts]     = useState([]);
  const [loading,    setLoading]    = useState(true);

  useEffect(() => {
    Promise.all([
      api.get('/dashboard/kpis'),
      api.get('/dashboard/atm-status'),
      api.get('/dashboard/weekly-chart'),
      api.get('/dashboard/recent-alerts'),
    ]).then(([k, g, c, a]) => {
      setKpis(k.data);
      setAtmGrid(g.data);
      setChart(c.data);
      setAlerts(a.data);
    }).finally(() => setLoading(false));
  }, []);

  const cashPct = (atm) => {
    const val = Number(atm.current_cash);
    const cap = Number(atm.max_capacity);
    if (!cap) return 0;
    return Math.min(100, Math.round((val / cap) * 100));
  };

  const cashColor = (pct) =>
    pct < 20 ? 'bg-red-500' : pct < 40 ? 'bg-orange' : 'bg-green-500';

  const atmCardColor = (atm) => {
    if (atm.status === 'maintenance') return 'atm-maintenance';
    if (atm.status === 'inactive')    return 'atm-inactive';
    const pct = cashPct(atm);
    if (pct < 20) return 'atm-low-cash';
    return 'atm-active';
  };

  if (loading) return (
    <div className="flex items-center justify-center h-64">
      <div className="flex flex-col items-center gap-3 text-navy-400">
        <div className="w-10 h-10 border-4 border-navy border-t-orange rounded-full animate-spin" />
        <p className="text-sm font-medium">Loading dashboard…</p>
      </div>
    </div>
  );

  return (
    <div className="space-y-6 animate-fadeInUp">
      {/* ── KPI Cards ── */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
        {[
          { label: 'Total ATMs',      value: kpis?.totalAtms,  icon: <Landmark size={24}/>,          bg: 'from-navy to-navy-600' },
          { label: 'Active ATMs',     value: kpis?.activeAtms, icon: <CheckCircle size={24}/>,        bg: 'from-green-600 to-green-500' },
          { label: "Today's Txns",    value: kpis?.todayTxns,  icon: <ArrowUpRight size={24}/>,       bg: 'from-orange to-orange-600' },
          { label: 'Low Cash Alerts', value: kpis?.lowCashAlerts, icon: <AlertTriangle size={24}/>,   bg: 'from-red-600 to-red-500' },
        ].map((k, i) => (
          <div key={i} className="kpi-card card-hover">
            <div className={`kpi-icon bg-gradient-to-br ${k.bg}`}>{k.icon}</div>
            <div>
              <p className="text-3xl font-extrabold text-navy">{k.value ?? '—'}</p>
              <p className="text-sm text-gray-500 font-medium">{k.label}</p>
            </div>
          </div>
        ))}
      </div>

      {/* ── Row 2: Chart + Alerts ── */}
      <div className="grid grid-cols-1 xl:grid-cols-3 gap-5">
        {/* 7-day chart */}
        <div className="card xl:col-span-2">
          <div className="flex items-center justify-between mb-5">
            <div>
              <p className="section-title mb-0">7-Day Withdrawal Trend</p>
              <p className="text-xs text-gray-400">All ATMs combined</p>
            </div>
            <span className="badge badge-active">Live</span>
          </div>
          <ResponsiveContainer width="100%" height={220}>
            <LineChart data={chart} margin={{ top: 5, right: 10, left: 0, bottom: 0 }}>
              <CartesianGrid strokeDasharray="3 3" stroke="#e8eaed" />
              <XAxis dataKey="date" tickFormatter={fmtDate} tick={{ fontSize: 11, fill: '#6b7280' }} />
              <YAxis tickFormatter={v => `₹${(v/100000).toFixed(0)}L`} tick={{ fontSize: 11, fill: '#6b7280' }} width={55} />
              <Tooltip content={<ChartTooltip />} />
              <Line
                type="monotone" dataKey="total"
                stroke="#E87722" strokeWidth={3}
                dot={{ r: 4, fill: '#E87722', stroke: '#fff', strokeWidth: 2 }}
                activeDot={{ r: 6 }}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>

        {/* Recent Alerts */}
        <div className="card flex flex-col">
          <div className="flex items-center justify-between mb-4">
            <p className="section-title mb-0">Recent Alerts</p>
            <Link to="/alerts" className="text-xs text-orange hover:underline font-semibold">View all →</Link>
          </div>
          <div className="space-y-3 flex-1">
            {alerts.length === 0 && <p className="text-sm text-gray-400 text-center py-6">No active alerts 🎉</p>}
            {alerts.map(a => (
              <div key={a.alert_id} className={`flex gap-3 p-3 rounded-xl border-l-4 ${ALT_COLOR[a.severity] || 'bg-gray-50 border-gray-300'}`}>
                <span className="mt-0.5 flex-shrink-0">{ALERT_ICON[a.alert_type]}</span>
                <div className="min-w-0">
                  <p className="text-xs font-semibold uppercase tracking-wide">{a.alert_type.replace('_',' ')}</p>
                  <p className="text-xs text-gray-600 truncate">{a.city} – {a.serial_number}</p>
                  <p className="text-xs text-gray-400 mt-0.5">{a.severity} severity</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* ── ATM Status Grid ── */}
      <div className="card">
        <div className="flex items-center justify-between mb-5">
          <p className="section-title mb-0">ATM Status Grid</p>
          <div className="flex items-center gap-3 text-xs text-gray-500">
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-green-500 inline-block"/>Active</span>
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-orange inline-block"/>Low Cash</span>
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-yellow-500 inline-block"/>Maintenance</span>
            <span className="flex items-center gap-1"><span className="w-2 h-2 rounded-full bg-red-400 inline-block"/>Inactive</span>
          </div>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4">
          {atmGrid.map(a => {
            const pct = cashPct(a);
            return (
              <div key={a.atm_id} className={`card card-hover ${atmCardColor(a)} rounded-xl p-4`}>
                <div className="flex justify-between items-start mb-2">
                  <p className="font-bold text-sm text-navy">{a.serial_number?.replace('SBI-ATM-','')}</p>
                  <span className={`badge ${ATM_STATUS_COLOR[a.status] || ''}`}>{a.status}</span>
                </div>
                <p className="text-xs text-gray-500 mb-3">{a.city}</p>
                <div className="mb-1 flex justify-between text-xs text-gray-600">
                  <span>Cash Level</span>
                  <span className={pct < 20 ? 'text-red-600 font-bold' : ''}>{pct}%</span>
                </div>
                <div className="progress-bar-bg">
                  <div className={`progress-bar-fill ${cashColor(pct)}`} style={{ width: `${pct}%` }} />
                </div>
                <p className="text-xs text-gray-400 mt-2">{fmt(Number(a.current_cash))} / {fmt(Number(a.max_capacity))}</p>
              </div>
            );
          })}
        </div>
      </div>

      {/* ── Quick Actions ── */}
      <div className="card">
        <p className="section-title">Quick Actions</p>
        <div className="flex flex-wrap gap-3">
          <Link to="/replenishment" className="btn-primary flex items-center gap-2">
            <Plus size={16}/> Add Replenishment
          </Link>
          <Link to="/atms" className="btn-secondary flex items-center gap-2">
            <Wrench size={16}/> Log Maintenance
          </Link>
          <Link to="/transactions" className="btn-ghost flex items-center gap-2">
            <RefreshCcw size={16}/> View Transactions
          </Link>
        </div>
      </div>
    </div>
  );
}
