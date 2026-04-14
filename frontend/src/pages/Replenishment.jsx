import { useState, useEffect } from 'react';
import { Plus, CheckCircle, Truck, X } from 'lucide-react';
import api from '../api/client';

const fmt = v => `₹${(Number(v)/100000).toFixed(2)}L`;
const fmtDate = d => d ? new Date(d).toLocaleDateString('en-IN',{day:'numeric',month:'short',year:'numeric'}) : '—';

const STATUS_BADGE = {
  pending:    'badge badge-pending',
  approved:   'badge badge-approved',
  in_transit: 'badge bg-purple-100 text-purple-700',
  completed:  'badge badge-completed',
  cancelled:  'badge badge-failed',
};

// ── Request Modal ────────────────────────────────────────────────────────────
function RequestModal({ opts, onClose, onSave }) {
  const [form, setForm] = useState({
    atm_id:'', vendor_id:'', requested_by:'', scheduled_date:'', notes:'', denominations:[]
  });
  const set = (k,v) => setForm(f=>({...f,[k]:v}));

  const setDenom = (id, val, value) => {
    setForm(f => {
      const existing = f.denominations.filter(d => d.denomination_id !== id);
      if (!val || val===0) return {...f, denominations: existing};
      return {...f, denominations:[...existing, {denomination_id:id, notes_count:parseInt(val)||0, value}]};
    });
  };

  const totalAmount = form.denominations.reduce((s,d) => s + d.notes_count * d.value, 0);

  const save = async () => {
    try {
      await api.post('/replenishments', {...form, total_amount: totalAmount});
      onSave(); onClose();
    } catch(e) { alert(e.response?.data?.error || 'Failed'); }
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-box p-6" onClick={e=>e.stopPropagation()}>
        <div className="flex justify-between items-center mb-5">
          <h2 className="text-lg font-bold text-navy">New Replenishment Request</h2>
          <button onClick={onClose}><X size={20} className="text-gray-400"/></button>
        </div>
        <div className="space-y-4">
          <div>
            <label className="label">ATM *</label>
            <select className="select" value={form.atm_id} onChange={e=>set('atm_id',e.target.value)}>
              <option value="">Select ATM</option>
              {opts.atms?.map(a=><option key={a.atm_id} value={a.atm_id}>{a.serial_number} — {a.city}</option>)}
            </select>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="label">Vendor *</label>
              <select className="select" value={form.vendor_id} onChange={e=>set('vendor_id',e.target.value)}>
                <option value="">Select Vendor</option>
                {opts.vendors?.map(v=><option key={v.vendor_id} value={v.vendor_id}>{v.vendor_name}</option>)}
              </select>
            </div>
            <div>
              <label className="label">Requested By</label>
              <select className="select" value={form.requested_by} onChange={e=>set('requested_by',e.target.value)}>
                <option value="">Select Employee</option>
                {opts.employees?.map(e=><option key={e.employee_id} value={e.employee_id}>{e.name} ({e.role})</option>)}
              </select>
            </div>
          </div>
          <div>
            <label className="label">Scheduled Date</label>
            <input type="datetime-local" className="input" value={form.scheduled_date} onChange={e=>set('scheduled_date',e.target.value)}/>
          </div>

          {/* Denominations */}
          <div>
            <label className="label">Denomination Counts</label>
            <div className="grid grid-cols-2 gap-2">
              {opts.denominations?.map(d=>(
                <div key={d.denomination_id} className="flex items-center gap-2 bg-navy-50 rounded-lg p-2">
                  <span className="text-sm font-bold text-navy w-12">₹{d.value}</span>
                  <input type="number" min="0" placeholder="Count" className="input py-1 text-sm"
                    onChange={e=>setDenom(d.denomination_id, e.target.value, d.value)}/>
                </div>
              ))}
            </div>
          </div>

          <div className="bg-orange-50 rounded-xl p-3 text-center">
            <p className="text-xs text-gray-500">Total Amount</p>
            <p className="text-2xl font-extrabold text-orange">{fmt(totalAmount)}</p>
          </div>

          <div>
            <label className="label">Notes</label>
            <textarea className="input" rows={2} value={form.notes} onChange={e=>set('notes',e.target.value)}/>
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-4">
          <button onClick={onClose} className="btn-ghost">Cancel</button>
          <button onClick={save} className="btn-primary" disabled={!form.atm_id||!form.vendor_id}>Submit Request</button>
        </div>
      </div>
    </div>
  );
}

// ── Main Page ────────────────────────────────────────────────────────────────
export default function Replenishment() {
  const [list,     setList]     = useState([]);
  const [opts,     setOpts]     = useState({});
  const [loading,  setLoading]  = useState(true);
  const [showModal,setShowModal]= useState(false);

  const load = () => {
    setLoading(true);
    Promise.all([api.get('/replenishments'), api.get('/replenishments/meta/options')])
      .then(([r, o]) => { setList(r.data); setOpts(o.data); })
      .finally(() => setLoading(false));
  };
  useEffect(() => { load(); }, []);

  const approve = async (id) => {
    await api.patch(`/replenishments/${id}/approve`, { approved_by: 1 });
    load();
  };
  const complete = async (id) => {
    await api.patch(`/replenishments/${id}/complete`);
    load();
  };

  // Summary counts
  const pending   = list.filter(r=>r.status==='pending').length;
  const approved  = list.filter(r=>r.status==='approved').length;
  const completed = list.filter(r=>r.status==='completed').length;

  return (
    <div className="space-y-5 animate-fadeInUp">
      {/* Header */}
      <div className="page-header">
        <div>
          <h2 className="page-title">Cash Replenishment</h2>
          <p className="page-subtitle">Manage cash replenishment requests and approvals</p>
        </div>
        <button className="btn-primary flex items-center gap-2" onClick={()=>setShowModal(true)}>
          <Plus size={16}/> New Request
        </button>
      </div>

      {/* Workflow KPIs */}
      <div className="grid grid-cols-3 gap-4">
        {[
          { label:'Pending Approval', count: pending,   color:'bg-amber-500', icon:<Plus size={20}/> },
          { label:'Approved',         count: approved,  color:'bg-teal-500',  icon:<CheckCircle size={20}/> },
          { label:'Completed',        count: completed, color:'bg-green-600', icon:<Truck size={20}/> },
        ].map((s,i)=>(
          <div key={i} className="kpi-card">
            <div className={`kpi-icon ${s.color}`}>{s.icon}</div>
            <div>
              <p className="text-3xl font-extrabold text-navy">{s.count}</p>
              <p className="text-sm text-gray-500">{s.label}</p>
            </div>
          </div>
        ))}
      </div>

      {/* Table */}
      <div className="card overflow-x-auto">
        {loading ? (
          <div className="flex justify-center py-10"><div className="w-8 h-8 border-4 border-navy border-t-orange rounded-full animate-spin"/></div>
        ) : (
          <table className="data-table">
            <thead><tr>
              <th>#</th><th>ATM</th><th>Vendor</th><th>Amount</th>
              <th>Requested By</th><th>Approved By</th>
              <th>Scheduled</th><th>Status</th><th>Actions</th>
            </tr></thead>
            <tbody>
              {list.map(r=>(
                <tr key={r.replenishment_id}>
                  <td className="font-bold text-navy">#{r.replenishment_id}</td>
                  <td>
                    <p className="font-semibold text-xs">{r.serial_number?.replace('SBI-ATM-','')}</p>
                    <p className="text-xs text-gray-400">{r.city}</p>
                  </td>
                  <td className="text-xs">{r.vendor_name}</td>
                  <td className="font-bold text-navy">{fmt(r.total_amount)}</td>
                  <td className="text-xs">{r.requested_by_name||'—'}</td>
                  <td className="text-xs">{r.approved_by_name||<span className="text-gray-400 italic">Pending</span>}</td>
                  <td className="text-xs">{fmtDate(r.scheduled_date)}</td>
                  <td><span className={STATUS_BADGE[r.status]||'badge'}>{r.status?.replace('_',' ')}</span></td>
                  <td>
                    <div className="flex gap-1">
                      {r.status==='pending' && (
                        <button onClick={()=>approve(r.replenishment_id)} className="btn-primary btn-sm flex items-center gap-1">
                          <CheckCircle size={12}/> Approve
                        </button>
                      )}
                      {r.status==='approved' && (
                        <button onClick={()=>complete(r.replenishment_id)} className="btn-secondary btn-sm flex items-center gap-1">
                          <Truck size={12}/> Complete
                        </button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
              {list.length===0 && <tr><td colSpan={9} className="text-center py-8 text-gray-400">No replenishments yet.</td></tr>}
            </tbody>
          </table>
        )}
      </div>

      {showModal && <RequestModal opts={opts} onClose={()=>setShowModal(false)} onSave={load}/>}
    </div>
  );
}
