import { useState, useEffect } from 'react';
import { CheckCircle, AlertTriangle, Wifi, WifiOff, Cpu, ShieldAlert } from 'lucide-react';
import api from '../api/client';

const SEVERITY_BADGE = {
  critical: 'badge badge-critical',
  high:     'badge badge-high',
  medium:   'badge badge-medium',
  low:      'badge badge-low',
};
const SEVERITY_CARD = {
  critical: 'border-l-4 border-red-500 bg-red-50',
  high:     'border-l-4 border-orange bg-orange-50',
  medium:   'border-l-4 border-yellow-400 bg-yellow-50',
  low:      'border-l-4 border-blue-400 bg-blue-50',
};
const ALERT_ICONS = {
  low_cash:       <AlertTriangle size={20} className="text-red-500"/>,
  hardware_fault: <Cpu size={20} className="text-orange-500"/>,
  network_down:   <WifiOff size={20} className="text-blue-500"/>,
  vandalism:      <ShieldAlert size={20} className="text-red-600"/>,
};

const fmtAge = (m) => {
  if (m < 60) return `${m}m ago`;
  if (m < 1440) return `${Math.floor(m/60)}h ago`;
  return `${Math.floor(m/1440)}d ago`;
};
const fmtDT = d => d ? new Date(d).toLocaleString('en-IN',{day:'numeric',month:'short',hour:'2-digit',minute:'2-digit'}) : '—';

export default function AlertsAudit() {
  const [alerts,   setAlerts]   = useState([]);
  const [audit,    setAudit]    = useState([]);
  const [tab,      setTab]      = useState('alerts');
  const [loading,  setLoading]  = useState(true);

  const loadAlerts = () => {
    api.get('/alerts').then(r => setAlerts(r.data)).finally(()=>setLoading(false));
  };
  const loadAudit  = () => {
    api.get('/alerts/audit').then(r => setAudit(r.data));
  };

  useEffect(() => { loadAlerts(); loadAudit(); }, []);

  const resolve = async (id) => {
    await api.patch(`/alerts/${id}/resolve`, { resolved_by: 1 });
    loadAlerts(); loadAudit();
  };

  const active_count   = alerts.filter(a=>a.status==='active').length;
  const critical_count = alerts.filter(a=>a.severity==='critical').length;
  const resolved_count = alerts.filter(a=>a.status==='resolved').length;

  return (
    <div className="space-y-5 animate-fadeInUp">
      {/* KPIs */}
      <div className="grid grid-cols-3 gap-4">
        {[
          { label:'Active Alerts',    value: active_count,   icon:<AlertTriangle size={20}/>, color:'bg-red-500' },
          { label:'Critical',         value: critical_count, icon:<ShieldAlert   size={20}/>, color:'bg-orange' },
          { label:'Resolved Today',   value: resolved_count, icon:<CheckCircle   size={20}/>, color:'bg-green-600' },
        ].map((s,i)=>(
          <div key={i} className="kpi-card">
            <div className={`kpi-icon ${s.color}`}>{s.icon}</div>
            <div><p className="text-3xl font-extrabold text-navy">{s.value}</p>
            <p className="text-sm text-gray-500">{s.label}</p></div>
          </div>
        ))}
      </div>

      {/* Tab Strip */}
      <div className="flex gap-2 bg-white rounded-2xl p-1.5 shadow-card w-fit">
        {[{id:'alerts',label:'🔔 Active Alerts'},{id:'audit',label:'📋 Audit Log'}].map(t=>(
          <button key={t.id} onClick={()=>setTab(t.id)}
            className={`px-5 py-2 rounded-xl text-sm font-semibold transition-all ${tab===t.id?'bg-navy text-white shadow':'text-gray-500 hover:bg-navy-50 hover:text-navy'}`}>
            {t.label}
          </button>
        ))}
      </div>

      {/* Alerts Tab */}
      {tab==='alerts' && (
        <div className="space-y-3">
          {loading && <div className="flex justify-center py-10"><div className="w-8 h-8 border-4 border-navy border-t-orange rounded-full animate-spin"/></div>}
          {!loading && alerts.length === 0 && (
            <div className="card text-center py-12">
              <CheckCircle size={40} className="text-green-500 mx-auto mb-3"/>
              <p className="font-bold text-navy">All Clear!</p>
              <p className="text-gray-500 text-sm">No active alerts at this time.</p>
            </div>
          )}
          {alerts.map(a=>(
            <div key={a.alert_id} className={`card card-hover ${SEVERITY_CARD[a.severity]||'bg-gray-50'} flex gap-4 items-start`}>
              <div className="flex-shrink-0 mt-1">{ALERT_ICONS[a.alert_type]}</div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 flex-wrap mb-1">
                  <span className={SEVERITY_BADGE[a.severity]||'badge'}>{a.severity}</span>
                  <span className="badge bg-gray-100 text-gray-600 capitalize">{a.alert_type.replace('_',' ')}</span>
                  <span className="text-xs text-gray-400">{fmtAge(Number(a.age_minutes))}</span>
                </div>
                <p className="font-semibold text-navy text-sm">{a.serial_number} — {a.city}</p>
                <p className="text-sm text-gray-600 mt-1 leading-relaxed">{a.message}</p>
              </div>
              {a.status==='active' && (
                <button onClick={()=>resolve(a.alert_id)}
                  className="btn-primary btn-sm flex-shrink-0 flex items-center gap-1">
                  <CheckCircle size={14}/> Resolve
                </button>
              )}
              {a.status==='resolved' && (
                <span className="badge badge-active flex-shrink-0">Resolved</span>
              )}
            </div>
          ))}
        </div>
      )}

      {/* Audit Log Tab */}
      {tab==='audit' && (
        <div className="card overflow-x-auto">
          <p className="section-title">System Audit Trail</p>
          <table className="data-table">
            <thead><tr>
              <th>#</th><th>Entity</th><th>Entity ID</th><th>Action</th>
              <th>Changed By</th><th>Timestamp</th><th>Changes</th>
            </tr></thead>
            <tbody>
              {audit.map(l=>(
                <tr key={l.log_id}>
                  <td className="font-bold text-navy">#{l.log_id}</td>
                  <td><span className="badge bg-navy-50 text-navy">{l.entity_type}</span></td>
                  <td>{l.entity_id}</td>
                  <td>
                    <span className={`badge ${l.action==='insert'?'badge-approved':l.action==='delete'?'badge-failed':'badge-medium'}`}>
                      {l.action}
                    </span>
                  </td>
                  <td className="text-xs">{l.changed_by_name||`User #${l.changed_by}`}</td>
                  <td className="text-xs">{fmtDT(l.changed_at)}</td>
                  <td className="max-w-xs">
                    {l.new_values && <p className="text-xs font-mono truncate text-green-700">+ {JSON.stringify(l.new_values)}</p>}
                    {l.old_values && <p className="text-xs font-mono truncate text-red-600">- {JSON.stringify(l.old_values)}</p>}
                  </td>
                </tr>
              ))}
              {audit.length===0 && <tr><td colSpan={7} className="text-center py-8 text-gray-400">No audit records yet.</td></tr>}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
