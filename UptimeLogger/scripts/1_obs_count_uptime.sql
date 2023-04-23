SELECT count(*) into @obs_count
FROM uptime_log
WHERE date(time) = CURDATE();