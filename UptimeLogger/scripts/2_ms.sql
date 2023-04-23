WITH Ordered AS (
SELECT ROW_NUMBER() OVER (ORDER BY ms) AS RowNumber, ms
FROM uptime_log)
SELECT ms
FROM Ordered
WHERE RowNumber in (1, round(@obs_count/4), round(@obs_count/2), 3 * round(@obs_count/4), @obs_count);