import { useState, useEffect, useRef } from 'react';
import { Download, ChevronDown, ChevronRight, Filter } from 'lucide-react';
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer
} from 'recharts';
import api from '../api/client';

const fmt = v => `₹${(Number(v)/100000).toFixed(2)}L`;
const fmtDT = dt => new Date(dt).toLocaleString('en-IN',{day:'numeric',month:'short',hour:'2-digit',minute:'2-digit'});

const STATUS_BADGE = { success:'badge badge-success', failed:'badge badge-failed', reversed:'badge badge-maint' };

export default function Transactions() {
  const [rows,    setRows]    = useState([]);
  const [total,   setTotal]   = useState(0);
  const [stats,   setStats]   = useState(null);
  const [atms,    setAtms]    = useState([]);
  const [page,    setPage]    = useState(1);
  const [loading, setLoading] = useState(true);
  const [expanded,setExpanded]= useState(null);
  const [denoms,  setDenoms]  = useState({});
  const [filter,  setFilter]  = useState({ atm_id:'', start_date:'', end_date:'', status:'', type:'' });

  const load = (filters=filter, pg=page) => {
    setLoading(true);
    const p = { ...filters, page: pg, limit: 15 };
    api.get('/transactions', { params: p }).then(r => {
      setRows(r.data.data); setTotal(r.data.total);
    }).finally(() => setLoading(false));
  };

  useEffect(() => {
    api.get('/analytics/atm-list').then(r => setAtms(r.data));
    api.get('/transactions/stats/summary').then(r => setStats(r.data));
    load();
  }, []);

  const applyFilter = () => { setPage(1); load(filter, 1); };

  const toggleExpand = async (id) => {
    if (expanded === id) { setExpanded(null); return; }
    setExpanded(id);
    if (!denoms[id]) {
      const r = await api.get(`/transactions/${id}/denominations`);
      setDenoms(prev => ({ ...prev, [id]: r.data }));
    }
  };

  const exportCSV = () => {
    const params = new URLSearchParams(filter).toString();
    window.open(`http://localhost:5000/api/transactions/export/csv?${params}`);
  };

  const totalPages = Math.ceil(total / 15);

  return (
    <div className="space-y-5 animate-fadeInUp">
      {/* Stats */}
      {stats && (
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          {[
            { label: "Today's Withdrawals", value: fmt(stats.todayAmount), sub: `${stats.todayTxns} transactions` },
            { label: 'Success Rate',  value: `${stats.successRate}%`,      sub: 'across all ATMs' },
            { label: 'Total Records', value: total.toLocaleString('en-IN'), sub: 'matching current filter' },
          ].map((s,i) => (
            <div key={i} className="card text-center">
              <p className="text-2xl font-extrabold text-navy">{s.value}</p>
              <p className="text-sm text-gray-500 font-medium">{s.label}</p>
              <p className="text-xs text-gray-400">{s.sub}</p>
            </div>
          ))}
        </div>
      )}

      {/* Peak Hour Chart */}
      {stats?.hourlyData?.length > 0 && (
        <div className="card">
          <p className="section-title">Today's Peak Hours</p>
          <ResponsiveContainer width="100%" height={130}>
            <BarChart data={stats.hourlyData} margin={{top:0,right:0,left:-20,bottom:0}}>
              <CartesianGrid strokeDasharray="3 3" stroke="#eee"/>
              <XAxis dataKey="hour" tickFormatter={h=>`${h}h`} tick={{fontSize:11}}/>
              <YAxis tick={{fontSize:11}}/>
              <Tooltip formatter={v=>[v,'Txns']}/>
              <Bar dataKey="count" fill="#E87722" radius={[4,4,0,0]}/>
            </BarChart>
          </ResponsiveContainer>
        </div>
      )}

      {/* Filters */}
      <div className="card">
        <div className="flex items-center gap-2 mb-3 text-navy font-semibold text-sm">
          <Filter size={15}/> Filters
        </div>
        <div className="grid grid-cols-2 lg:grid-cols-5 gap-3">
          <div>
            <label className="label">ATM</label>
            <select className="select" value={filter.atm_id} onChange={e=>setFilter(f=>({...f,atm_id:e.target.value}))}>
              <option value="">All ATMs</option>
              {atms.map(a=><option key={a.atm_id} value={a.atm_id}>{a.serial_number}</option>)}
            </select>
          </div>
          <div>
            <label className="label">From Date</label>
            <input type="date" className="input" value={filter.start_date} onChange={e=>setFilter(f=>({...f,start_date:e.target.value}))}/>
          </div>
          <div>
            <label className="label">To Date</label>
            <input type="date" className="input" value={filter.end_date} onChange={e=>setFilter(f=>({...f,end_date:e.target.value}))}/>
          </div>
          <div>
            <label className="label">Status</label>
            <select className="select" value={filter.status} onChange={e=>setFilter(f=>({...f,status:e.target.value}))}>
              <option value="">All</option>
              <option value="success">Success</option>
              <option value="failed">Failed</option>
              <option value="reversed">Reversed</option>
            </select>
          </div>
          <div>
            <label className="label">Type</label>
            <select className="select" value={filter.type} onChange={e=>setFilter(f=>({...f,type:e.target.value}))}>
              <option value="">All</option>
              <option value="withdrawal">Withdrawal</option>
              <option value="balance_inquiry">Balance Inquiry</option>
              <option value="mini_statement">Mini Statement</option>
            </select>
          </div>
        </div>
        <div className="flex gap-3 mt-3">
          <button className="btn-primary btn-sm" onClick={applyFilter}>Apply Filters</button>
          <button className="btn-ghost btn-sm" onClick={()=>{setFilter({atm_id:'',start_date:'',end_date:'',status:'',type:''});setTimeout(()=>load({},1),50);}}>Clear</button>
          <button className="btn-secondary btn-sm flex items-center gap-1 ml-auto" onClick={exportCSV}>
            <Download size={14}/> Export CSV
          </button>
        </div>
      </div>

      {/* Table */}
      <div className="card overflow-x-auto">
        {loading ? (
          <div className="flex justify-center py-10"><div className="w-8 h-8 border-4 border-navy border-t-orange rounded-full animate-spin"/></div>
        ) : (
          <>
            <table className="data-table">
              <thead><tr>
                <th></th><th>Ref #</th><th>Date & Time</th><th>ATM</th>
                <th>Type</th><th>Amount</th><th>Status</th>
              </tr></thead>
              <tbody>
                {rows.map(r => (
                  <>
                    <tr key={r.transaction_id} className="cursor-pointer" onClick={()=>toggleExpand(r.transaction_id)}>
                      <td className="w-8 text-gray-400">
                        {expanded===r.transaction_id ? <ChevronDown size={14}/> : <ChevronRight size={14}/>}
                      </td>
                      <td className="font-mono text-xs">{r.reference_number}</td>
                      <td className="text-xs">{fmtDT(r.txn_datetime)}</td>
                      <td>
                        <p className="font-semibold text-xs">{r.serial_number?.replace('SBI-ATM-','')}</p>
                        <p className="text-xs text-gray-400">{r.city}</p>
                      </td>
                      <td className="capitalize text-xs">{r.transaction_type?.replace('_',' ')}</td>
                      <td className="font-bold text-navy">₹{Number(r.amount).toLocaleString('en-IN')}</td>
                      <td><span className={STATUS_BADGE[r.status]||'badge'}>{r.status}</span></td>
                    </tr>
                    {expanded === r.transaction_id && (
                      <tr key={`exp-${r.transaction_id}`} className="bg-navy-50">
                        <td colSpan={7} className="px-6 py-3">
                          <p className="text-xs font-semibold text-navy mb-2">Denomination Breakdown</p>
                          {denoms[r.transaction_id] ? (
                            <div className="flex flex-wrap gap-3">
                              {denoms[r.transaction_id].map(d=>(
                                <div key={d.td_id} className="bg-white border border-navy-100 rounded-lg px-3 py-2 text-xs">
                                  <p className="font-bold text-navy">₹{d.value} × {d.notes_count}</p>
                                  <p className="text-gray-400">= ₹{Number(d.subtotal).toLocaleString('en-IN')}</p>
                                </div>
                              ))}
                            </div>
                          ) : <div className="w-5 h-5 border-2 border-navy border-t-transparent rounded-full animate-spin"/>}
                          {r.failure_reason && (
                            <p className="text-red-600 text-xs mt-2 font-medium">⚠ {r.failure_reason}</p>
                          )}
                        </td>
                      </tr>
                    )}
                  </>
                ))}
                {rows.length === 0 && (
                  <tr><td colSpan={7} className="text-center py-8 text-gray-400">No transactions found.</td></tr>
                )}
              </tbody>
            </table>
            {/* Pagination */}
            <div className="flex items-center justify-between mt-4 text-sm text-gray-500">
              <p>Showing {rows.length} of {total.toLocaleString('en-IN')} records</p>
              <div className="flex gap-2">
                <button onClick={()=>{const p=page-1;setPage(p);load(filter,p);}} disabled={page===1} className="btn-ghost btn-sm disabled:opacity-40">← Prev</button>
                <span className="px-3 py-1 bg-navy text-white rounded text-xs font-bold">{page} / {totalPages}</span>
                <button onClick={()=>{const p=page+1;setPage(p);load(filter,p);}} disabled={page>=totalPages} className="btn-ghost btn-sm disabled:opacity-40">Next →</button>
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
