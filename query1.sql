--
-- Query 1. Total expenses
--
SELECT round(SUM(timestampdiff(second, Timestamp_start, Timestamp_end)*money),2) AS 'total expenses'
FROM Rates, Call_logs LEFT JOIN Call_forwarding ON Call_logs.To=Call_forwarding.From 
WHERE ((Call_logs.To NOT IN (SELECT Call_forwarding.From FROM Call_forwarding)) AND (Call_logs.To IN (SELECT Numbers.Phone_Number FROM Numbers)) OR (Call_logs.To IN (SELECT Call_forwarding.From FROM Call_forwarding)) AND (Call_forwarding.To IN (SELECT Numbers.Phone_Number FROM Numbers))) AND Call_logs.Call_dir='out' AND money=(SELECT Rates.Money FROM Rates WHERE Rates.ID='1') OR 
Call_logs.Call_dir='in' AND money=(SELECT Rates.Money FROM Rates WHERE Rates.ID='2') OR 
((Call_logs.To NOT IN (SELECT Call_forwarding.From FROM Call_forwarding)) AND (Call_logs.To NOT IN (SELECT Numbers.Phone_Number FROM Numbers)) OR (Call_logs.To IN (SELECT Call_forwarding.From FROM Call_forwarding)) AND (Call_forwarding.To NOT IN (SELECT numbers.Phone_Number FROM Numbers))) AND Call_logs.Call_dir='out' AND money=(SELECT Rates.Money FROM Rates WHERE Rates.ID='3')
