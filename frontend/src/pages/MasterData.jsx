import { useState, useEffect } from 'react';
import { Plus, Pencil, X } from 'lucide-react';
import api from '../api/client';

const TABS = [
  { id:'banks',        label:'🏦 Banks' },
  { id:'branches',     label:'🌿 Branches' },
  { id:'employees',    label:'👤 Employees' },
  { id:'customers',    label:'🧑 Customers' },
  { id:'cards',        label:'💳 Cards' },
  { id:'vendors',      label:'🚛 CIT Vendors' },
  { id:'denominations',label:'₹ Denominations' },
];

// ── Generic Modal wrapper ─────────────────────────────────────────────────────
function Modal({ title, onClose, onSave, children }) {
  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-box p-6" onClick={e=>e.stopPropagation()}>
        <div className="flex justify-between items-center mb-5">
          <h2 className="text-lg font-bold text-navy">{title}</h2>
          <button onClick={onClose}><X size={20} className="text-gray-400 hover:text-red-500"/></button>
        </div>
        {children}
        <div className="flex justify-end gap-3 mt-5">
          <button onClick={onClose} className="btn-ghost">Cancel</button>
          <button onClick={onSave} className="btn-primary">Save</button>
        </div>
      </div>
    </div>
  );
}

// ── BANKS ────────────────────────────────────────────────────────────────────
function BanksTab() {
  const [list,setList]=useState([]);
  const [showModal,setShowModal]=useState(false);
  const [form,setForm]=useState({bank_name:'',swift_code:'',headquarters:'',phone:'',established_date:'',status:'active'});
  const set=(k,v)=>setForm(f=>({...f,[k]:v}));
  const load=()=>api.get('/master/banks').then(r=>setList(r.data));
  useEffect(()=>{load();},[]);
  const save=async()=>{await api.post('/master/banks',form);load();setShowModal(false);};

  return (
    <>
      <div className="flex justify-end mb-3">
        <button className="btn-primary flex items-center gap-2" onClick={()=>setShowModal(true)}><Plus size={14}/> Add Bank</button>
      </div>
      <table className="data-table">
        <thead><tr><th>ID</th><th>Bank Name</th><th>SWIFT</th><th>Headquarters</th><th>Phone</th><th>Status</th></tr></thead>
        <tbody>
          {list.map(b=>(
            <tr key={b.bank_id}>
              <td className="font-bold text-navy">#{b.bank_id}</td>
              <td className="font-semibold">{b.bank_name}</td>
              <td className="font-mono text-xs">{b.swift_code}</td>
              <td className="text-xs">{b.headquarters}</td>
              <td>{b.phone}</td>
              <td><span className={`badge ${b.status==='active'?'badge-active':'badge-inactive'}`}>{b.status}</span></td>
            </tr>
          ))}
        </tbody>
      </table>
      {showModal && (
        <Modal title="Add Bank" onClose={()=>setShowModal(false)} onSave={save}>
          <div className="grid grid-cols-2 gap-3">
            <div className="col-span-2"><label className="label">Bank Name</label><input className="input" value={form.bank_name} onChange={e=>set('bank_name',e.target.value)}/></div>
            <div><label className="label">SWIFT Code</label><input className="input" value={form.swift_code} onChange={e=>set('swift_code',e.target.value)}/></div>
            <div><label className="label">Phone</label><input className="input" value={form.phone} onChange={e=>set('phone',e.target.value)}/></div>
            <div className="col-span-2"><label className="label">Headquarters</label><input className="input" value={form.headquarters} onChange={e=>set('headquarters',e.target.value)}/></div>
            <div><label className="label">Established Date</label><input type="date" className="input" value={form.established_date} onChange={e=>set('established_date',e.target.value)}/></div>
          </div>
        </Modal>
      )}
    </>
  );
}

// ── BRANCHES ─────────────────────────────────────────────────────────────────
function BranchesTab() {
  const [list,setList]=useState([]);
  const load=()=>api.get('/master/branches').then(r=>setList(r.data));
  useEffect(()=>{load();},[]);
  return (
    <table className="data-table">
      <thead><tr><th>ID</th><th>Branch Name</th><th>IFSC</th><th>Bank</th><th>City</th><th>State</th><th>Manager</th><th>Status</th></tr></thead>
      <tbody>
        {list.map(b=>(
          <tr key={b.branch_id}>
            <td className="font-bold text-navy">#{b.branch_id}</td>
            <td className="font-semibold">{b.branch_name}</td>
            <td className="font-mono text-xs">{b.ifsc_code}</td>
            <td>{b.bank_name}</td>
            <td>{b.city}</td>
            <td>{b.state}</td>
            <td className="text-xs">{b.manager_name||'—'}</td>
            <td><span className={`badge ${b.status==='active'?'badge-active':'badge-inactive'}`}>{b.status}</span></td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

// ── EMPLOYEES ────────────────────────────────────────────────────────────────
function EmployeesTab() {
  const [list,setList]=useState([]);
  const [showModal,setShowModal]=useState(false);
  const [form,setForm]=useState({branch_id:'',first_name:'',last_name:'',email:'',phone:'',role:'cashier',hire_date:'',status:'active'});
  const set=(k,v)=>setForm(f=>({...f,[k]:v}));
  const [branches,setBranches]=useState([]);
  const load=()=>api.get('/master/employees').then(r=>setList(r.data));
  useEffect(()=>{load();api.get('/master/branches').then(r=>setBranches(r.data));},[]);
  const save=async()=>{await api.post('/master/employees',form);load();setShowModal(false);};

  const ROLE_BADGE={manager:'badge bg-purple-100 text-purple-700',technician:'badge badge-medium',cashier:'badge badge-approved',admin:'badge badge-completed'};

  return (
    <>
      <div className="flex justify-end mb-3">
        <button className="btn-primary flex items-center gap-2" onClick={()=>setShowModal(true)}><Plus size={14}/> Add Employee</button>
      </div>
      <table className="data-table">
        <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Branch</th><th>Status</th></tr></thead>
        <tbody>
          {list.map(e=>(
            <tr key={e.employee_id}>
              <td className="font-bold text-navy">#{e.employee_id}</td>
              <td className="font-semibold">{e.first_name} {e.last_name}</td>
              <td className="text-xs">{e.email}</td>
              <td>{e.phone}</td>
              <td><span className={ROLE_BADGE[e.role]||'badge'}>{e.role}</span></td>
              <td className="text-xs">{e.branch_name} – {e.city}</td>
              <td><span className={`badge ${e.status==='active'?'badge-active':'badge-inactive'}`}>{e.status}</span></td>
            </tr>
          ))}
        </tbody>
      </table>
      {showModal && (
        <Modal title="Add Employee" onClose={()=>setShowModal(false)} onSave={save}>
          <div className="grid grid-cols-2 gap-3">
            <div><label className="label">First Name</label><input className="input" value={form.first_name} onChange={e=>set('first_name',e.target.value)}/></div>
            <div><label className="label">Last Name</label><input className="input" value={form.last_name} onChange={e=>set('last_name',e.target.value)}/></div>
            <div className="col-span-2"><label className="label">Email</label><input type="email" className="input" value={form.email} onChange={e=>set('email',e.target.value)}/></div>
            <div><label className="label">Phone</label><input className="input" value={form.phone} onChange={e=>set('phone',e.target.value)}/></div>
            <div><label className="label">Role</label>
              <select className="select" value={form.role} onChange={e=>set('role',e.target.value)}>
                {['manager','technician','cashier','admin'].map(r=><option key={r}>{r}</option>)}
              </select>
            </div>
            <div><label className="label">Branch</label>
              <select className="select" value={form.branch_id} onChange={e=>set('branch_id',e.target.value)}>
                <option value="">Select</option>
                {branches.map(b=><option key={b.branch_id} value={b.branch_id}>{b.branch_name}</option>)}
              </select>
            </div>
            <div><label className="label">Hire Date</label><input type="date" className="input" value={form.hire_date} onChange={e=>set('hire_date',e.target.value)}/></div>
          </div>
        </Modal>
      )}
    </>
  );
}

// ── CUSTOMERS ────────────────────────────────────────────────────────────────
function CustomersTab() {
  const [list,setList]=useState([]);
  useEffect(()=>{api.get('/master/customers').then(r=>setList(r.data));},[]);
  return (
    <table className="data-table">
      <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Aadhar</th><th>PAN</th><th>KYC</th><th>Status</th></tr></thead>
      <tbody>{list.map(c=>(
        <tr key={c.customer_id}>
          <td className="font-bold text-navy">#{c.customer_id}</td>
          <td>{c.first_name} {c.last_name}</td>
          <td className="text-xs">{c.email}</td>
          <td>{c.phone}</td>
          <td className="font-mono text-xs">{c.aadhar_number}</td>
          <td className="font-mono text-xs">{c.pan_number}</td>
          <td><span className={`badge ${c.kyc_status==='verified'?'badge-approved':c.kyc_status==='rejected'?'badge-failed':'badge-medium'}`}>{c.kyc_status}</span></td>
          <td><span className={`badge ${c.status==='active'?'badge-active':'badge-inactive'}`}>{c.status}</span></td>
        </tr>
      ))}</tbody>
    </table>
  );
}

// ── CARDS ────────────────────────────────────────────────────────────────────
function CardsTab() {
  const [list,setList]=useState([]);
  useEffect(()=>{api.get('/master/cards').then(r=>setList(r.data));},[]);
  return (
    <table className="data-table">
      <thead><tr><th>ID</th><th>Customer</th><th>Account</th><th>Type</th><th>Network</th><th>Expiry</th><th>Int'l</th><th>Status</th></tr></thead>
      <tbody>{list.map(c=>(
        <tr key={c.card_id}>
          <td className="font-bold text-navy">#{c.card_id}</td>
          <td>{c.customer_name}</td>
          <td className="font-mono text-xs">{c.account_number}</td>
          <td><span className="badge bg-navy-50 text-navy capitalize">{c.card_type}</span></td>
          <td className="capitalize">{c.network}</td>
          <td className="text-xs">{new Date(c.expiry_date).toLocaleDateString('en-IN',{month:'short',year:'2-digit'})}</td>
          <td>{c.international_enabled?'✅':'❌'}</td>
          <td><span className={`badge ${c.status==='active'?'badge-active':c.status==='blocked'?'badge-failed':'badge-inactive'}`}>{c.status}</span></td>
        </tr>
      ))}</tbody>
    </table>
  );
}

// ── VENDORS ──────────────────────────────────────────────────────────────────
function VendorsTab() {
  const [list,setList]=useState([]);
  const [showModal,setShowModal]=useState(false);
  const [form,setForm]=useState({vendor_name:'',contact_person:'',phone:'',email:'',license_number:'',contract_start:'',contract_end:'',status:'active'});
  const set=(k,v)=>setForm(f=>({...f,[k]:v}));
  const load=()=>api.get('/master/vendors').then(r=>setList(r.data));
  useEffect(()=>{load();},[]);
  const save=async()=>{await api.post('/master/vendors',form);load();setShowModal(false);};
  const fmtD=d=>d?new Date(d).toLocaleDateString('en-IN',{day:'numeric',month:'short',year:'numeric'}):'—';

  return (
    <>
      <div className="flex justify-end mb-3">
        <button className="btn-primary flex items-center gap-2" onClick={()=>setShowModal(true)}><Plus size={14}/> Add Vendor</button>
      </div>
      <table className="data-table">
        <thead><tr><th>ID</th><th>Vendor Name</th><th>Contact</th><th>Phone</th><th>Email</th><th>Contract End</th><th>Status</th></tr></thead>
        <tbody>{list.map(v=>(
          <tr key={v.vendor_id}>
            <td className="font-bold text-navy">#{v.vendor_id}</td>
            <td className="font-semibold">{v.vendor_name}</td>
            <td>{v.contact_person}</td>
            <td>{v.phone}</td>
            <td className="text-xs">{v.email}</td>
            <td className="text-xs">{fmtD(v.contract_end)}</td>
            <td><span className={`badge ${v.status==='active'?'badge-active':v.status==='expired'?'badge-failed':'badge-inactive'}`}>{v.status}</span></td>
          </tr>
        ))}</tbody>
      </table>
      {showModal && (
        <Modal title="Add CIT Vendor" onClose={()=>setShowModal(false)} onSave={save}>
          <div className="grid grid-cols-2 gap-3">
            <div className="col-span-2"><label className="label">Vendor Name</label><input className="input" value={form.vendor_name} onChange={e=>set('vendor_name',e.target.value)}/></div>
            <div><label className="label">Contact Person</label><input className="input" value={form.contact_person} onChange={e=>set('contact_person',e.target.value)}/></div>
            <div><label className="label">Phone</label><input className="input" value={form.phone} onChange={e=>set('phone',e.target.value)}/></div>
            <div><label className="label">Email</label><input type="email" className="input" value={form.email} onChange={e=>set('email',e.target.value)}/></div>
            <div><label className="label">License #</label><input className="input" value={form.license_number} onChange={e=>set('license_number',e.target.value)}/></div>
            <div><label className="label">Contract Start</label><input type="date" className="input" value={form.contract_start} onChange={e=>set('contract_start',e.target.value)}/></div>
            <div><label className="label">Contract End</label><input type="date" className="input" value={form.contract_end} onChange={e=>set('contract_end',e.target.value)}/></div>
          </div>
        </Modal>
      )}
    </>
  );
}

// ── DENOMINATIONS ────────────────────────────────────────────────────────────
function DenominationsTab() {
  const [list,setList]=useState([]);
  const [showModal,setShowModal]=useState(false);
  const [form,setForm]=useState({currency_code:'INR',value:'',description:''});
  const set=(k,v)=>setForm(f=>({...f,[k]:v}));
  const load=()=>api.get('/master/denominations').then(r=>setList(r.data));
  useEffect(()=>{load();},[]);
  const save=async()=>{await api.post('/master/denominations',form);load();setShowModal(false);};

  return (
    <>
      <div className="flex justify-end mb-3">
        <button className="btn-primary flex items-center gap-2" onClick={()=>setShowModal(true)}><Plus size={14}/> Add Denomination</button>
      </div>
      <table className="data-table">
        <thead><tr><th>ID</th><th>Currency</th><th>Value</th><th>Description</th></tr></thead>
        <tbody>{list.map(d=>(
          <tr key={d.denomination_id}>
            <td className="font-bold text-navy">#{d.denomination_id}</td>
            <td><span className="badge bg-navy-50 text-navy">{d.currency_code}</span></td>
            <td><span className="font-extrabold text-navy text-lg">₹{d.value}</span></td>
            <td>{d.description}</td>
          </tr>
        ))}</tbody>
      </table>
      {showModal && (
        <Modal title="Add Denomination" onClose={()=>setShowModal(false)} onSave={save}>
          <div className="space-y-3">
            <div><label className="label">Currency Code</label><input className="input" value={form.currency_code} onChange={e=>set('currency_code',e.target.value)}/></div>
            <div><label className="label">Value (₹)</label><input type="number" className="input" value={form.value} onChange={e=>set('value',e.target.value)}/></div>
            <div><label className="label">Description</label><input className="input" value={form.description} onChange={e=>set('description',e.target.value)}/></div>
          </div>
        </Modal>
      )}
    </>
  );
}

// ── Main Page ────────────────────────────────────────────────────────────────
const TAB_COMPONENTS = {
  banks: BanksTab,
  branches: BranchesTab,
  employees: EmployeesTab,
  customers: CustomersTab,
  cards: CardsTab,
  vendors: VendorsTab,
  denominations: DenominationsTab,
};

export default function MasterData() {
  const [active, setActive] = useState('banks');
  const ActiveTab = TAB_COMPONENTS[active];

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div>
        <h2 className="page-title">Master Data</h2>
        <p className="page-subtitle">Manage reference data for all entities</p>
      </div>

      {/* Tab Strip */}
      <div className="flex gap-1.5 flex-wrap bg-white rounded-2xl p-1.5 shadow-card">
        {TABS.map(t=>(
          <button key={t.id} onClick={()=>setActive(t.id)}
            className={`px-3 py-2 rounded-xl text-sm font-semibold transition-all ${active===t.id?'bg-navy text-white shadow':'text-gray-500 hover:bg-navy-50 hover:text-navy'}`}>
            {t.label}
          </button>
        ))}
      </div>

      <div className="card overflow-x-auto">
        <ActiveTab/>
      </div>
    </div>
  );
}
