SELECT TOP 100
substring(st.TEXT,charindex(' from ',st.TEXT)+1,25) as [From]
 ,st.TEXT
 ,creation_time
, last_execution_time
, total_logical_reads AS [LogicalReads] , total_logical_writes AS [LogicalWrites] 
, (total_worker_time+0.0)/1000 AS total_worker_time
, (total_worker_time+0.0)/(execution_count*1000) AS [AvgCPUTime] , execution_count
, total_logical_reads+total_logical_writes AS [AggIO] , (total_logical_reads+total_logical_writes)/(execution_count+0.0) AS [AvgIO]
, DB_NAME(st.dbid) AS database_name
, st.objectid AS OBJECT_ID
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(sql_handle) st
WHERE total_logical_reads+total_logical_writes > 0
AND sql_handle IS NOT NULL
ORDER BY [AvgIO] DESC