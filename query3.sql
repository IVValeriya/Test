--
-- Query 3. Top 10: users with highest chargers and daily 
-- distribution for each of them
--
SELECT call_logs.UID, round(sum(timestampdiff(second, Timestamp_start, Timestamp_end)*money),2) AS 'charges',  sum(timestampdiff(second, Timestamp_start, Timestamp_end)) AS 'total_time', round(sum(timestampdiff(second, Timestamp_start, Timestamp_end)*money)/sum(timestampdiff(second, Timestamp_start, Timestamp_end)), 2) AS 'avg' 
FROM rates, call_logs LEFT JOIN call_forwarding ON call_logs.To=call_forwarding.From 
WHERE ((call_logs.To NOT IN (SELECT call_forwarding.From FROM call_forwarding)) AND (call_logs.To IN (SELECT numbers.Phone_Number FROM numbers)) OR (call_logs.To IN (SELECT call_forwarding.From FROM call_forwarding)) AND (call_forwarding.To IN (SELECT numbers.Phone_Number FROM numbers))) AND call_logs.Call_dir='out' AND money=(SELECT rates.Money FROM rates WHERE rates.ID='1') 
OR
call_logs.Call_dir='in' AND money=(SELECT rates.Money FROM rates WHERE rates.ID='2') 
OR 
((call_logs.To NOT IN (SELECT call_forwarding.From FROM call_forwarding)) AND (call_logs.To NOT IN (SELECT numbers.Phone_Number FROM numbers)) OR (call_logs.To IN (SELECT call_forwarding.From FROM call_forwarding)) AND (call_forwarding.To NOT IN (SELECT numbers.Phone_Number FROM numbers))) AND call_logs.Call_dir='out' AND money=(SELECT rates.Money FROM rates WHERE rates.ID='3') 
GROUP BY call_logs.UID
ORDER BY round(sum(timestampdiff(second, Timestamp_start, Timestamp_end)*money),2) DESC
LIMIT 10
