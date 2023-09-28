-- Signal Waits for instance
SELECT CAST(100.0 * SUM(signal_wait_time_ms) / SUM (wait_time_ms) AS NUMERIC(20,2)) 
AS [%signal (cpu) waits],
CAST(100.0 * SUM(wait_time_ms - signal_wait_time_ms) / SUM (wait_time_ms) AS NUMERIC(20,2)) 
AS [%resource waits]
FROM sys.dm_os_wait_stats;

-- Signal Waits above 10-15% is usually a sign of CPU pressure