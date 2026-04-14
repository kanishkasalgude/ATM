const fs = require('fs');
let out = '';
let d = 0;
while (d < 30) {
    let txn_date = new Date();
    txn_date.setDate(txn_date.getDate() - (29 - d));
    let day_of_week_val = txn_date.getDay();
    let num_txns, base_amt;
    if (day_of_week_val === 0 || day_of_week_val === 6) {
        num_txns = 8 + Math.floor(Math.random() * 5);
        base_amt = 13000 + Math.floor(Math.random() * 2000);
    } else {
        num_txns = 5 + Math.floor(Math.random() * 4);
        base_amt = 8000 + Math.floor(Math.random() * 2000);
    }
    if (txn_date.getDate() >= 28) {
        base_amt *= 1.30;
        num_txns += 3;
    }
    for (let i = 0; i < num_txns; i++) {
        let atm_pick = 1 + Math.floor(Math.random() * 5);
        let card_pick = 1 + Math.floor(Math.random() * 5);
        let acc_pick = card_pick;
        let amt = Math.round((2000 + Math.floor(Math.random() * 8000)) / 100) * 100;
        let bal_before = 100000 + Math.floor(Math.random() * 200000);
        let bal_after = bal_before - amt;
        let ref_num = 'REF' + String(Math.floor(Math.random() * 9999999)).padStart(7, '0') + d + i;
        let d500 = Math.floor(amt / 500);
        let d200 = Math.floor((amt - d500 * 500) / 200);
        let d100 = Math.floor((amt - d500 * 500 - d200 * 200) / 100);
        let dt_str = txn_date.toISOString().split('T')[0] + ' ' + String(10 + Math.floor(Math.random() * 8)).padStart(2, '0') + ':' + String(Math.floor(Math.random() * 60)).padStart(2, '0') + ':00';
        let session_id = 'SES' + String(Math.floor(Math.random() * 999999)).padStart(6, '0');
        
        out += `INSERT INTO \`TRANSACTION\` (atm_id, card_id, account_id, transaction_type, amount, txn_datetime, reference_number, balance_before, balance_after, status, session_id) VALUES (${atm_pick}, ${card_pick}, ${acc_pick}, 'withdrawal', ${amt}, '${dt_str}', '${ref_num}', ${bal_before}, ${bal_after}, 'success', '${session_id}');\n`;
        
        out += 'SET @last_txn_id = LAST_INSERT_ID();\n';
        if (d500 > 0) out += `INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 1, ${d500});\n`;
        if (d200 > 0) out += `INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 2, ${d200});\n`;
        if (d100 > 0) out += `INSERT INTO TXN_DENOMINATION (transaction_id, denomination_id, notes_count) VALUES (@last_txn_id, 3, ${d100});\n`;
    }
    d++;
}

let seed_path = 'db/seed.sql';
let seed_content = fs.readFileSync(seed_path, 'utf8');
let start_idx = seed_content.indexOf('DROP PROCEDURE IF EXISTS gen_transactions;');
let end_idx = seed_content.indexOf(';', seed_content.indexOf('CALL gen_transactions()')) + 1;
let end_idx_final = seed_content.indexOf('DROP PROCEDURE IF EXISTS gen_transactions;', end_idx);
if (end_idx_final !== -1) {
    end_idx = end_idx_final + 'DROP PROCEDURE IF EXISTS gen_transactions;'.length;
}

if (start_idx !== -1 && end_idx > start_idx) {
    let replaced = seed_content.substring(0, start_idx) + out + seed_content.substring(end_idx);
    fs.writeFileSync(seed_path, replaced);
    console.log('Successfully replaced procedure with static SQL.');
} else {
    console.log('Could not find bounds');
}
