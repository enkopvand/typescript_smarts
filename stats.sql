SELECT DISTINCT s.name as SchemaName,OBJECT_NAME(o.OBJECT_ID) AS TableName, p.row_count, COL_NAME(o.object_id,c.column_id) AS ColumnName
FROM 
SYS.objects o JOIN SYS.schemas s
		 ON o.schema_id=s.schema_id
		      JOIN sys.dm_db_partition_stats p
		 ON o.object_id=p.object_id
			  JOIN SYS.columns c
		 ON o.object_id=c.object_id
WHERE o.type LIKE 'U' 
AND s.name LIKE 'accounts'   -- schema name
ORDER BY TableName
