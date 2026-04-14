import { useState, useEffect } from 'react';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
  ReferenceLine
} from 'recharts';
import api from '../api/client';

const TABS = [
  { id:'forecast',    label:'📈 Moving Average Forecast' },
  { id:'safety',      label:'🛡️ Safety Cash Calculator' },
  { id:'simulation',  label:'📊 Cash Balance Simulation' },
  { id:'optimize',    label:'⚙️ Optimization Engine' },
];

// ── Pre-filled example data ──────────────────────────────────────────────────
const EXAMPLE_DAYS = [
  {label:'Mon', demand:800000},
  {label:'Tue', demand:900000},
  {label:'Wed', demand:1000000},
  {label:'Thu', demand:900000},
  {label:'Fri', demand:1100000},
  {label:'Sat', demand:1400000},
  {label:'Sun', demand:1500000},
];

// ── Formula Badge ────────────────────────────────────────────────────────────
function Formula({ children }) {
  return (
    <div className="formula-card my-3">
      <code className="text-navy font-semibold">{children}</code>
    </div>
  );
}

// ── Result Card ──────────────────────────────────────────────────────────────
function ResultCard({ label, value, highlight }) {
  return (
    <div className={`rounded-2xl p-5 text-center ${highlight ? 'bg-orange text-white' : 'bg-navy-50 text-navy'}`}>
      <p className={`text-xs font-semibold uppercase tracking-wide mb-1 ${highlight ? 'text-orange-100' : 'text-gray-500'}`}>{label}</p>
      <p className="text-2xl font-extrabold">{value}</p>
    </div>
  );
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 1 — Moving Average Forecasting
// ────────────────────────────────────────────────────────────────────────────
function ForecastTab({ atms }) {
  const [atmId, setAtmId]   = useState('');
  const [n, setN]           = useState(7);
  const [maData, setMaData] = useState(null);
  const [loading, setLoading]= useState(false);
  const [useExample, setUseExample] = useState(true);

  const loadMA = async () => {
    if (!atmId) return;
    setLoading(true);
    const r = await api.get(`/analytics/moving-average/${atmId}`, { params: { n } });
    setMaData(r.data); setUseExample(false);
    setLoading(false);
  };

  const source = useExample ? {
    data: EXAMPLE_DAYS.map((d,i)=>({ date:d.label, total:d.demand })),
    n: 7,
    days: EXAMPLE_DAYS.map(d=>d.demand),
    avg: EXAMPLE_DAYS.reduce((s,d)=>s+d.demand,0)/7,
    avgLakhs: 11,
  } : maData;

  const avg = source?.avgLakhs;

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div className="card bg-navy-50 border border-navy-100">
        <p className="font-bold text-navy mb-2">📐 Formula</p>
        <Formula>D̂(t+1) = [D(t) + D(t-1) + ... + D(t-n+1)] / n</Formula>
        <p className="text-xs text-gray-600">Where D̂(t+1) = predicted demand for next day, n = window size</p>
      </div>

      <div className="card">
        <p className="section-title">Select ATM & Parameters</p>
        <div className="flex flex-wrap gap-3 items-end">
          <div>
            <label className="label">ATM</label>
            <select className="select w-56" value={atmId} onChange={e=>setAtmId(e.target.value)}>
              <option value="">Use Example Data</option>
              {atms.map(a=><option key={a.atm_id} value={a.atm_id}>{a.serial_number}</option>)}
            </select>
          </div>
          <div>
            <label className="label">Window (n days)</label>
            <input type="number" className="input w-24" min="3" max="30" value={n} onChange={e=>setN(e.target.value)}/>
          </div>
          <button className="btn-primary" onClick={loadMA} disabled={!atmId||loading}>
            {loading ? 'Loading…' : 'Calculate'}
          </button>
        </div>
      </div>

      {source && (
        <div className="space-y-4">
          <div className="card">
            <p className="section-title">Day-by-Day Demand Data (last {source.n} days)</p>
            <div className="flex flex-wrap gap-2 mb-4">
              {source.data.map((d,i)=>(
                <div key={i} className="bg-navy-50 rounded-xl px-4 py-2 text-center min-w-[80px]">
                  <p className="text-xs text-gray-500">{d.date}</p>
                  <p className="font-bold text-navy text-sm">₹{(d.total/100000).toFixed(1)}L</p>
                </div>
              ))}
            </div>
            <div className="bg-orange-50 border border-orange-200 rounded-xl p-4">
              <p className="text-xs text-orange-600 font-semibold uppercase tracking-wide mb-1">Step-by-step:</p>
              <p className="text-sm text-gray-700 font-mono">
                D̂ = ({source.days.map(d=>`${(d/100000).toFixed(1)}`).join(' + ')}) / {source.n}
              </p>
              <p className="text-sm text-gray-700 font-mono font-bold mt-1">
                D̂ = {(source.days.reduce((a,b)=>a+b,0)/100000).toFixed(2)} / {source.n} = <span className="text-orange">₹{avg}L</span>
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <ResultCard label="Window Size" value={`${source.n} days`}/>
            <ResultCard label="Predicted Tomorrow" value={`₹${avg}L`} highlight/>
            <ResultCard label="Pattern" value={avg>11?'High Demand':'Normal'}/>
          </div>
        </div>
      )}
    </div>
  );
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 2 — Safety Cash Calculator
// ────────────────────────────────────────────────────────────────────────────
const Z_VALUES = { '90%': 1.28, '95%': 1.65, '99%': 2.33 };

function SafetyTab() {
  const [mu,      setMu]    = useState(11);
  const [sigma,   setSigma] = useState(2);
  const [zLevel,  setZLevel]= useState('95%');

  const z        = Z_VALUES[zLevel];
  const safety   = +(z * sigma).toFixed(2);
  const minCash  = +(mu + safety).toFixed(2);

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div className="card bg-navy-50 border border-navy-100 space-y-2">
        <p className="font-bold text-navy mb-2">📐 Formulas</p>
        <Formula>Safety Cash  =  Z × σ</Formula>
        <Formula>Min Required = μ + Safety Cash</Formula>
        <Formula>C(t+1) = C(t) − D(t) + R(t)</Formula>
        <p className="text-xs text-gray-600">Where μ=mean demand, σ=std deviation, Z=service-level z-score, R(t)=replenishment</p>
      </div>

      <div className="card">
        <p className="section-title">Input Parameters</p>
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <div>
            <label className="label">Mean Demand μ (Lakhs)</label>
            <input type="number" className="input" value={mu} step="0.1" onChange={e=>setMu(+e.target.value)}/>
          </div>
          <div>
            <label className="label">Std Deviation σ (Lakhs)</label>
            <input type="number" className="input" value={sigma} step="0.1" onChange={e=>setSigma(+e.target.value)}/>
          </div>
          <div>
            <label className="label">Service Level</label>
            <select className="select" value={zLevel} onChange={e=>setZLevel(e.target.value)}>
              {Object.entries(Z_VALUES).map(([k,v])=>(
                <option key={k} value={k}>{k} → Z = {v}</option>
              ))}
            </select>
          </div>
        </div>
      </div>

      <div className="card">
        <p className="section-title">Step-by-Step Calculation</p>
        <div className="space-y-2">
          {[
            `1. Z-score for ${zLevel} service level = ${z}`,
            `2. Safety Cash = Z × σ = ${z} × ${sigma} = ₹${safety}L`,
            `3. Min Required = μ + Safety Cash = ${mu} + ${safety} = ₹${minCash}L`,
          ].map((s,i)=>(
            <div key={i} className="flex items-center gap-3 bg-navy-50 rounded-xl p-3">
              <span className="w-6 h-6 bg-navy text-white rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0">{i+1}</span>
              <p className="text-sm text-gray-700 font-mono">{s}</p>
            </div>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <ResultCard label={`Z-Score (${zLevel})`} value={z}/>
        <ResultCard label="Safety Cash Buffer" value={`₹${safety}L`}/>
        <ResultCard label="Safe Cash Level" value={`₹${minCash}L`} highlight/>
      </div>
    </div>
  );
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 3 — Cash Balance Simulation
// ────────────────────────────────────────────────────────────────────────────
function SimulationTab() {
  const [startBalance,  setStartBalance]  = useState(50);
  const [dailyDemand,   setDailyDemand]   = useState(11);
  const [replAmount,    setReplAmount]    = useState(40);
  const [replFreq,      setReplFreq]      = useState(7);
  const [safety,        setSafety]        = useState(14.3);

  const simulate = () => {
    let C = startBalance;
    const data = [];
    for (let d = 1; d <= 30; d++) {
      const demand = dailyDemand + (Math.random() - 0.5) * 2; // slight variation
      let R = 0;
      if (d % replFreq === 0) R = replAmount;
      C = C - demand + R;
      if (C < 0) C = 0;
      data.push({ day: `D${d}`, balance: +C.toFixed(2), replenishment: R > 0 ? C : null, demand: +demand.toFixed(2) });
    }
    return data;
  };

  const [simData, setSimData] = useState(() => simulate());

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div className="card bg-navy-50 border border-navy-100">
        <p className="font-bold text-navy mb-2">📐 Recurrence Formula</p>
        <Formula>C(t+1) = C(t) − D(t) + R(t)</Formula>
        <p className="text-xs text-gray-600">C=cash balance, D=demand, R=replenishment amount on day t</p>
      </div>

      <div className="card">
        <p className="section-title">Simulation Parameters</p>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {[
            {label:'Start Balance (L)',  val:startBalance, set:setStartBalance},
            {label:'Avg Daily Demand (L)',val:dailyDemand, set:setDailyDemand},
            {label:'Replenishment Amt (L)',val:replAmount, set:setReplAmount},
            {label:'Replenish Every N Days',val:replFreq,set:setReplFreq},
          ].map((p,i)=>(
            <div key={i}>
              <label className="label">{p.label}</label>
              <input type="number" className="input" value={p.val} step="0.1" onChange={e=>p.set(+e.target.value)}/>
            </div>
          ))}
        </div>
        <div className="mt-3 flex items-center gap-3">
          <div>
            <label className="label">Safety Threshold (L)</label>
            <input type="number" className="input w-32" value={safety} step="0.1" onChange={e=>setSafety(+e.target.value)}/>
          </div>
          <button className="btn-primary mt-5" onClick={()=>setSimData(simulate())}>Run Simulation</button>
        </div>
      </div>

      <div className="card">
        <p className="section-title">30-Day Cash Balance Forecast</p>
        <p className="text-xs text-gray-500 mb-3">
          🟢 Regular balance &nbsp;|&nbsp; 🔴 Red dashed = safety threshold &nbsp;|&nbsp; 🟠 Dots = replenishment days
        </p>
        <ResponsiveContainer width="100%" height={280}>
          <LineChart data={simData} margin={{top:5,right:10,left:0,bottom:0}}>
            <CartesianGrid strokeDasharray="3 3" stroke="#e8eaed"/>
            <XAxis dataKey="day" tick={{fontSize:10}}/>
            <YAxis tickFormatter={v=>`₹${v}L`} tick={{fontSize:11}} width={55}/>
            <Tooltip formatter={(v,name)=>[`₹${v}L`, name]}/>
            <ReferenceLine y={safety} stroke="#E87722" strokeDasharray="6 3" label={{value:`Safety ₹${safety}L`,position:'insideTopRight',fontSize:11,fill:'#E87722'}}/>
            <Line type="monotone" dataKey="balance" stroke="#1B2A6B" strokeWidth={2.5}
              dot={(props) => {
                const { cx,cy,payload } = props;
                if (!payload.replenishment) return null;
                return <circle key={cx} cx={cx} cy={cy} r={6} fill="#22c55e" stroke="#fff" strokeWidth={2}/>;
              }}
              activeDot={{r:5}}
            />
          </LineChart>
        </ResponsiveContainer>
        <p className="text-xs text-gray-400 mt-2 text-center">Green dots = replenishment events every {replFreq} days</p>
      </div>
    </div>
  );
}

// ────────────────────────────────────────────────────────────────────────────
// TAB 4 — Optimization Engine
// ────────────────────────────────────────────────────────────────────────────
function OptimizeTab() {
  const [refillCost,    setRefillCost]    = useState(5000);
  const [holdingPct,    setHoldingPct]    = useState(0.1);
  const [shortageCost,  setShortageCost]  = useState(50000);
  const [atmCapacity,   setAtmCapacity]   = useState(130);
  const [avgDemand,     setAvgDemand]     = useState(11);

  // Discrete-math optimization: minimize total daily cost
  const optimize = () => {
    let bestCost  = Infinity;
    let bestFreq  = 1;
    let bestAmt   = avgDemand;
    for (let freq = 1; freq <= 14; freq++) {
      const amount      = avgDemand * freq;
      const holdingAmt  = amount / 2;
      const dailyHolding= holdingAmt * 100000 * (holdingPct / 100);
      const dailyRefill = refillCost / freq;
      const shortage    = amount > atmCapacity ? 0 : Math.max(0, (1 - amount / atmCapacity)) * shortageCost / freq;
      const total       = dailyHolding + dailyRefill + shortage;
      if (total < bestCost && amount <= atmCapacity) {
        bestCost = total; bestFreq = freq; bestAmt = amount;
      }
    }
    const cashout = Math.max(1, Math.round((avgDemand / bestAmt) * 100 * 0.5));
    return { freq: bestFreq, amount: bestAmt, cost: Math.round(bestCost), cashout };
  };

  const result = optimize();

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div className="card bg-navy-50 border border-navy-100">
        <p className="font-bold text-navy mb-2">📐 Objective Function</p>
        <Formula>Minimize: TC = (Refill Cost / Freq) + (Holding Cost × Avg Balance) + (Shortage Cost × P[stockout])</Formula>
        <p className="text-xs text-gray-600">Decision variables: Refill Amount, Refill Frequency</p>
      </div>

      <div className="card">
        <p className="section-title">Input Parameters</p>
        <div className="grid grid-cols-2 sm:grid-cols-3 gap-4">
          {[
            {label:'Refill Cost (₹/trip)',     val:refillCost,   set:setRefillCost},
            {label:'Holding Cost (%/day)',      val:holdingPct,   set:setHoldingPct, step:'0.01'},
            {label:'Shortage Cost (₹/event)',   val:shortageCost, set:setShortageCost},
            {label:'ATM Capacity (Lakhs)',       val:atmCapacity,  set:setAtmCapacity},
            {label:'Avg Daily Demand (Lakhs)',   val:avgDemand,    set:setAvgDemand, step:'0.5'},
          ].map((p,i)=>(
            <div key={i}>
              <label className="label">{p.label}</label>
              <input type="number" className="input" value={p.val} step={p.step||'1'} onChange={e=>p.set(+e.target.value)}/>
            </div>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
        <ResultCard label="Optimal Refill Amount" value={`₹${result.amount}L`}/>
        <ResultCard label="Optimal Frequency"     value={`Every ${result.freq} Days`}/>
        <ResultCard label="Cash-out Probability"  value={`< ${result.cashout}%`}/>
        <ResultCard label="Optimal Strategy"      value="Balanced" highlight/>
      </div>

      <div className="card bg-green-50 border border-green-200">
        <p className="font-semibold text-green-800">✅ Recommended Strategy</p>
        <p className="text-sm text-green-700 mt-1">
          Refill <strong>₹{result.amount} Lakhs</strong> every <strong>{result.freq} day{result.freq>1?'s':''}</strong> to minimize total cost.
          Estimated daily operational cost: <strong>₹{result.cost.toLocaleString('en-IN')}</strong>.
          Cash-out probability: <strong>&lt;{result.cashout}%</strong>.
        </p>
        <p className="text-xs text-green-600 mt-1 italic">Optimal Strategy = Balanced Cost + High Availability</p>
      </div>
    </div>
  );
}

// ── Main Analytics Page ──────────────────────────────────────────────────────
export default function Analytics() {
  const [tab,  setTab]  = useState('forecast');
  const [atms, setAtms] = useState([]);

  useEffect(() => {
    api.get('/analytics/atm-list').then(r => setAtms(r.data)).catch(()=>{});
  }, []);

  return (
    <div className="space-y-5 animate-fadeInUp">
      <div className="page-header">
        <div>
          <h2 className="page-title">Analytics & Forecasting</h2>
          <p className="page-subtitle">Discrete Mathematics models for ATM cash management optimization</p>
        </div>
      </div>

      {/* Tab Strip */}
      <div className="flex gap-2 flex-wrap bg-white rounded-2xl p-1.5 shadow-card w-fit">
        {TABS.map(t=>(
          <button key={t.id}
            onClick={()=>setTab(t.id)}
            className={`px-4 py-2 rounded-xl text-sm font-semibold transition-all duration-200 ${
              tab===t.id ? 'bg-navy text-white shadow-md' : 'text-gray-500 hover:bg-navy-50 hover:text-navy'
            }`}>
            {t.label}
          </button>
        ))}
      </div>

      {/* Tab Content */}
      {tab === 'forecast'   && <ForecastTab atms={atms}/>}
      {tab === 'safety'     && <SafetyTab/>}
      {tab === 'simulation' && <SimulationTab/>}
      {tab === 'optimize'   && <OptimizeTab/>}
    </div>
  );
}
