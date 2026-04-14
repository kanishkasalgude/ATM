export default function ComparativeAnalysis() {
  const methods = [
    {
      name: 'Manual Estimation',
      accuracy: 'Low',
      cost: 'Low',
      complexity: 'Easy',
      suitability: 'Not reliable for large networks',
      highlight: false,
    },
    {
      name: 'Fixed Refill Schedule',
      accuracy: 'Medium',
      cost: 'Medium',
      complexity: 'Simple',
      suitability: 'May cause cash shortage/overflow',
      highlight: false,
    },
    {
      name: 'Predictive Analytics Model',
      accuracy: 'Very High',
      cost: 'High',
      complexity: 'Complex',
      suitability: 'Best for large-scale ATM networks',
      highlight: true,
    },
  ];

  const approaches = [
    {
      title: '1. Fixed Schedule Replenishment',
      icon: '🗓️',
      desc: 'Cash is replenished at fixed intervals regardless of actual demand. Simple to implement but often leads to either cash-outs or excess holding costs.',
      pros: ['Easy to plan', 'Predictable vendor schedule'],
      cons: ['Ignores demand variability', 'High cash-out risk on weekends/month-end'],
    },
    {
      title: '2. Threshold-Based Replenishment',
      icon: '📉',
      desc: 'Replenishment is triggered when cash falls below a predefined threshold. Better than fixed schedule but reactive rather than proactive.',
      pros: ['Prevents cash-out', 'Automatic trigger'],
      cons: ['May still require emergency replenishment', 'Threshold tuning is non-trivial'],
    },
    {
      title: '3. Historical Average Method',
      icon: '📈',
      desc: 'Uses moving average of past N days to forecast next-day demand. This is the core Discrete Mathematics model used in this project.',
      pros: ['Simple formula', 'Adapts to recent trends', 'Accounts for seasonality'],
      cons: ['Lags behind sudden demand spikes', 'Needs sufficient history'],
    },
    {
      title: '4. Manual Monitoring System',
      icon: '👁️',
      desc: 'Operators manually monitor ATM cash levels and trigger replenishment. Prone to human error and delays, especially at night and weekends.',
      pros: ['No tech investment', 'Flexible'],
      cons: ['High labor cost', 'Error-prone', 'Not scalable'],
    },
    {
      title: '5. Cash Logistics Vendor Scheduling (Brink\'s, Loomis)',
      icon: '🚛',
      desc: 'Outsourced to specialized CIT (Cash-in-Transit) vendors who optimize routes and schedules, often integrating predictive analytics at a network level.',
      pros: ['Professional expertise', 'Route optimization', 'Insurance coverage'],
      cons: ['Higher vendor cost', 'Less control', 'SLA dependency'],
    },
  ];

  return (
    <div className="space-y-6 animate-fadeInUp">
      <div className="page-header">
        <div>
          <h2 className="page-title">Comparative Analysis</h2>
          <p className="page-subtitle">Evaluating ATM cash management strategies</p>
        </div>
      </div>

      {/* ── Comparison Table ── */}
      <div className="card overflow-x-auto">
        <p className="section-title">Method Comparison Matrix</p>
        <table className="data-table">
          <thead>
            <tr>
              <th>Method</th>
              <th>Accuracy Level</th>
              <th>Cost</th>
              <th>Implementation Complexity</th>
              <th>Suitability</th>
            </tr>
          </thead>
          <tbody>
            {methods.map((m, i) => (
              <tr key={i} className={m.highlight ? '!bg-orange-500' : ''}>
                <td className={`font-bold ${m.highlight ? 'text-white' : 'text-navy'}`}>{m.name}</td>
                <td>
                  <span className={`badge ${
                    m.accuracy==='Very High' ? (m.highlight?'bg-white text-orange-700':'badge-completed') :
                    m.accuracy==='Medium'    ? 'badge-medium' : 'badge-failed'
                  }`}>{m.accuracy}</span>
                </td>
                <td className={m.highlight?'text-orange-100':'text-gray-700'}>{m.cost}</td>
                <td className={m.highlight?'text-orange-100':'text-gray-700'}>{m.complexity}</td>
                <td className={`font-medium ${m.highlight?'text-white':'text-gray-700'}`}>{m.suitability}</td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* Conclusion */}
        <div className="mt-5 bg-navy rounded-2xl p-5 text-white">
          <p className="font-bold text-lg mb-2">📌 Conclusion</p>
          <p className="text-navy-100 leading-relaxed">
            Statistical Analysis and Predictive Analytics provide better accuracy, optimized cash refill scheduling,
            and reduced operational cost. They are the <strong className="text-orange">most suitable solutions</strong> for
            effective ATM cash management in large banking networks.
          </p>
        </div>
      </div>

      {/* ── Approach Cards ── */}
      <p className="page-title text-base mt-2">Detailed Approach Breakdown</p>
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
        {approaches.map((a, i) => (
          <div key={i} className={`card card-hover ${i===2?'border-2 border-orange ring-2 ring-orange-100':''}`}>
            <div className="flex items-center gap-3 mb-3">
              <span className="text-2xl">{a.icon}</span>
              <div>
                <p className={`font-bold ${i===2?'text-orange':'text-navy'}`}>{a.title}</p>
                {i===2 && <span className="badge badge-approved text-xs">Recommended ✓</span>}
              </div>
            </div>
            <p className="text-sm text-gray-600 mb-4 leading-relaxed">{a.desc}</p>
            <div className="grid grid-cols-2 gap-3">
              <div>
                <p className="text-xs font-semibold text-green-700 mb-1">✅ Pros</p>
                <ul className="space-y-1">
                  {a.pros.map((p,j)=><li key={j} className="text-xs text-gray-600">• {p}</li>)}
                </ul>
              </div>
              <div>
                <p className="text-xs font-semibold text-red-600 mb-1">❌ Cons</p>
                <ul className="space-y-1">
                  {a.cons.map((c,j)=><li key={j} className="text-xs text-gray-600">• {c}</li>)}
                </ul>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
