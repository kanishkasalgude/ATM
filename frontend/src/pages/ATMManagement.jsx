import { useState, useEffect } from 'react';
import { Plus, Pencil, PowerOff, ChevronRight, X } from 'lucide-react';
import api from '../api/client';

const fmt = (v) => `₹${(Number(v) / 100000).toFixed(2)}L`;
const pct  = (cur, cap) => (!cap ? 0 : Math.min(100, Math.round((Number(cur) / Number(cap)) * 100)));
const cashColor = (p) => (p < 20 ? 'bg-red-500' : p < 40 ? 'bg-orange' : 'bg-green-500');

const STATUS_BADGE = {
  active:      'badge badge-active',
  inactive:    'badge badge-inactive',
  maintenance: 'badge badge-maint',
};

// ── Add/Edit Modal ───────────────────────────────────────────────────────────
function ATMModal({ atm, branches, onClose, onSave }) {
  const [form, setForm] = useState(
    atm || { branch_id:'1', serial_number:'SBI-ATM-PUN-010', model:'NCR SelfServ 80', manufacturer:'NCR Corporation', location_address:'FC Road, Pune', atm_type:'onsite', max_capacity:15000000, software_version:'v5.0.2', status:'active' }
  );
  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const save = async () => {
    try {
      if (atm) await api.put(`/atms/${atm.atm_id}`, form);
      else      await api.post('/atms', form);
      onSave();
      onClose();
    } catch(e) { alert(e.response?.data?.error || 'Save failed'); }
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-box p-6" onClick={e => e.stopPropagation()}>
        <div className="flex justify-between items-center mb-5">
          <h2 className="text-lg font-bold text-navy">{atm ? 'Edit ATM' : 'Add New ATM'}</h2>
          <button onClick={onClose} className="text-gray-400 hover:text-red-500"><X size={20}/></button>
        </div>
        <div className="grid grid-cols-2 gap-4">
          {!atm && <>
            <div className="col-span-2">
              <label className="label">Branch</label>
              <select className="select" value={form.branch_id} onChange={e=>set('branch_id',e.target.value)}>
                <option value="">Select Branch</option>
                {branches.map(b=><option key={b.branch_id} value={b.branch_id}>{b.branch_name} – {b.city}</option>)}
              </select>
            </div>
            <div>
              <label className="label">Serial Number</label>
              <input className="input" value={form.serial_number} onChange={e=>set('serial_number',e.target.value)} />
            </div>
          </>}
          <div>
            <label className="label">Model</label>
            <input className="input" value={form.model} onChange={e=>set('model',e.target.value)} />
          </div>
          <div>
            <label className="label">Manufacturer</label>
            <input className="input" value={form.manufacturer} onChange={e=>set('manufacturer',e.target.value)} />
          </div>
          <div className="col-span-2">
            <label className="label">Location Address</label>
            <input className="input" value={form.location_address} onChange={e=>set('location_address',e.target.value)} />
          </div>
          <div>
            <label className="label">ATM Type</label>
            <select className="select" value={form.atm_type} onChange={e=>set('atm_type',e.target.value)}>
              <option value="onsite">Onsite</option>
              <option value="offsite">Offsite</option>
              <option value="mobile">Mobile</option>
            </select>
          </div>
          <div>
            <label className="label">Max Capacity (₹)</label>
            <input className="input" type="number" value={form.max_capacity} onChange={e=>set('max_capacity',e.target.value)} />
          </div>
          <div>
            <label className="label">Software Version</label>
            <input className="input" value={form.software_version} onChange={e=>set('software_version',e.target.value)} />
          </div>
          <div>
            <label className="label">Status</label>
            <select className="select" value={form.status} onChange={e=>set('status',e.target.value)}>
              <option value="active">Active</option>
              <option value="inactive">Inactive</option>
              <option value="maintenance">Maintenance</option>
            </select>
          </div>
        </div>
        <div className="flex justify-end gap-3 mt-6">
          <button onClick={onClose} className="btn-ghost">Cancel</button>
          <button onClick={save}    className="btn-primary">Save ATM</button>
        </div>
      </div>
    </div>
  );
}

// ── Cassette Detail Modal ────────────────────────────────────────────────────
function CassetteModal({ atm, onClose }) {
  if (!atm) return null;
  const totalCash = atm.cassettes?.reduce((s, c) => s + Number(c.cash_value), 0) || 0;
  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-box p-6 max-w-2xl" onClick={e=>e.stopPropagation()}>
        <div className="flex justify-between items-center mb-5">
          <div>
            <h2 className="text-lg font-bold text-navy">{atm.serial_number}</h2>
            <p className="text-sm text-gray-500">{atm.location_address}</p>
          </div>
          <button onClick={onClose} className="text-gray-400 hover:text-red-500"><X size={20}/></button>
        </div>

        <div className="grid grid-cols-3 gap-3 mb-5">
          <div className="bg-navy-50 rounded-xl p-3 text-center">
            <p className="text-xs text-gray-500">Total Cash</p>
            <p className="text-lg font-bold text-navy">{fmt(totalCash)}</p>
          </div>
          <div className="bg-orange-50 rounded-xl p-3 text-center">
            <p className="text-xs text-gray-500">Capacity</p>
            <p className="text-lg font-bold text-orange">{fmt(atm.max_capacity)}</p>
          </div>
          <div className="bg-green-50 rounded-xl p-3 text-center">
            <p className="text-xs text-gray-500">Status</p>
            <p className="text-lg font-bold text-green-700">{atm.status?.toUpperCase()}</p>
          </div>
        </div>

        <p className="section-title">Cassette Breakdown</p>
        <table className="data-table mb-4">
          <thead><tr>
            <th>Slot</th><th>Denomination</th><th>Count</th>
            <th>Max</th><th>Fill %</th><th>Cash Value</th><th>Status</th>
          </tr></thead>
          <tbody>
            {(atm.cassettes || []).map(c => {
              const p = Math.round((c.current_count / c.max_capacity) * 100);
              return (
                <tr key={c.cassette_id}>
                  <td className="font-semibold">#{c.cassette_slot}</td>
                  <td>₹{c.value}</td>
                  <td>{c.current_count.toLocaleString('en-IN')}</td>
                  <td>{c.max_capacity.toLocaleString('en-IN')}</td>
                  <td>
                    <div className="flex items-center gap-2">
                      <div className="progress-bar-bg w-20">
                        <div className={`progress-bar-fill ${cashColor(p)}`} style={{width:`${p}%`}}/>
                      </div>
                      <span className="text-xs">{p}%</span>
                    </div>
                  </td>
                  <td className="font-semibold">₹{Number(c.cash_value).toLocaleString('en-IN')}</td>
                  <td><span className={`badge ${c.status==='active'?'badge-active':c.status==='empty'?'badge-failed':'badge-maint'}`}>{c.status}</span></td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}

// ── Main Page ────────────────────────────────────────────────────────────────
export default function ATMManagement() {
  const [atms,       setAtms]       = useState([]);
  const [branches,   setBranches]   = useState([]);
  const [loading,    setLoading]    = useState(true);
  const [showAddModal,    setShowAddModal]    = useState(false);
  const [editingAtm,      setEditingAtm]      = useState(null);
  const [cassetteAtm,     setCassetteAtm]     = useState(null);
  const [cassetteLoading, setCassetteLoading] = useState(false);

  const load = () => {
    setLoading(true);
    Promise.all([api.get('/atms'), api.get('/atms/meta/branches')])
      .then(([a, b]) => { setAtms(a.data); setBranches(b.data); })
      .finally(() => setLoading(false));
  };
  useEffect(() => { load(); }, []);

  const viewCassettes = async (atm) => {
    setCassetteLoading(true);
    const res = await api.get(`/atms/${atm.atm_id}`);
    setCassetteAtm(res.data);
    setCassetteLoading(false);
  };

  const deactivate = async (id) => {
    if (!confirm('Deactivate this ATM?')) return;
    await api.patch(`/atms/${id}/deactivate`);
    load();
  };

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div className="page-header">
        <div>
          <h2 className="page-title">ATM Management</h2>
          <p className="page-subtitle">{atms.length} ATMs across all branches</p>
        </div>
        <button className="btn-primary flex items-center gap-2" onClick={() => setShowAddModal(true)}>
          <Plus size={16}/> Add ATM
        </button>
      </div>

      <div className="card overflow-x-auto">
        {loading ? (
          <div className="flex justify-center py-10">
            <div className="w-8 h-8 border-4 border-navy border-t-orange rounded-full animate-spin"/>
          </div>
        ) : (
          <table className="data-table">
            <thead><tr>
              <th>ATM ID</th><th>Serial Number</th><th>Location</th>
              <th>Branch / City</th><th>Type</th><th>Cash Level</th>
              <th>Status</th><th>Actions</th>
            </tr></thead>
            <tbody>
              {atms.map(a => {
                const p = pct(a.current_cash, a.max_capacity);
                return (
                  <tr key={a.atm_id}>
                    <td className="font-bold text-navy">#{a.atm_id}</td>
                    <td className="font-mono text-xs">{a.serial_number}</td>
                    <td className="max-w-xs truncate text-xs">{a.location_address}</td>
                    <td>{a.branch_name}<br/><span className="text-xs text-gray-400">{a.city}</span></td>
                    <td><span className="badge bg-navy-50 text-navy capitalize">{a.atm_type}</span></td>
                    <td>
                      <div className="flex items-center gap-2 min-w-[120px]">
                        <div className="progress-bar-bg flex-1">
                          <div className={`progress-bar-fill ${cashColor(p)}`} style={{width:`${p}%`}}/>
                        </div>
                        <span className="text-xs w-8">{p}%</span>
                      </div>
                      <p className="text-xs text-gray-400">{fmt(a.current_cash)}</p>
                    </td>
                    <td><span className={STATUS_BADGE[a.status] || 'badge'}>{a.status}</span></td>
                    <td>
                      <div className="flex items-center gap-1">
                        <button className="btn-ghost btn-sm flex items-center gap-1"
                          onClick={() => viewCassettes(a)}>
                          <ChevronRight size={14}/> Cassettes
                        </button>
                        <button className="btn-ghost btn-sm" onClick={() => setEditingAtm(a)}>
                          <Pencil size={14}/>
                        </button>
                        {a.status !== 'inactive' && (
                          <button className="btn-danger btn-sm" onClick={() => deactivate(a.atm_id)}>
                            <PowerOff size={14}/>
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        )}
      </div>

      {showAddModal && <ATMModal branches={branches} onClose={() => setShowAddModal(false)} onSave={load}/>}
      {editingAtm   && <ATMModal atm={editingAtm} branches={branches} onClose={() => setEditingAtm(null)} onSave={load}/>}
      {cassetteAtm  && <CassetteModal atm={cassetteAtm} onClose={() => setCassetteAtm(null)}/>}
    </div>
  );
}
