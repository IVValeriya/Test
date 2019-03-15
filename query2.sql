--
-- Query 2. Top 10: most active users
--
SELECT Call_logs.UID, Accounts.Name, SUM(timestampdiff(second, Timestamp_start, Timestamp_end)) AS 'total_time, sec'
FROM Call_logs LEFT JOIN Accounts ON Accounts.UID=Call_logs.UID
GROUP BY Call_logs.UID
ORDER BY SUM(timestampdiff(second, Timestamp_start, Timestamp_end)) DESC
LIMIT 10
