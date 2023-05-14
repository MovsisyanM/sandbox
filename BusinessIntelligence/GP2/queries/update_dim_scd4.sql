CREATE PROCEDURE {TARGET_SCHEMA}.dim_{SRC_TABLE}_SCD4_ETL
AS
BEGIN TRY
	DECLARE @TBL_SCD4 TABLE (
		{TBL_DEF}
	)

    MERGE [{TARGET_DB}].[{TARGET_SCHEMA}].[{TARGET_TABLE}] AS DST
    USING [{SRC_DB}].[{SRC_SCHEMA}].[{SRC_TABLE}] AS SRC 
    ON (DST.[{PKEY}] = SRC.[{PKEY}]) 
    --When records are matched, update the records if there is any change
    WHEN MATCHED 
        AND (
		{NULLDIFFS}
	)
    THEN UPDATE SET 
		{UPDATEDS}
    --When no records are matched, insert the incoming records from source table to target table
    WHEN NOT MATCHED
    THEN 
        INSERT (
			{COLS}
		)
        VALUES (
			{SRC_COLS}
		)
    --$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
    --one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
    OUTPUT SRC.{PKEY},
		{DELLEDS}
	into @TBL_SCD4 (
		{COLS}
	);

	insert into [{TARGET_DB}].[{TARGET_SCHEMA}].[{TARGET_TABLE}_History] (
		{COLS}
	)
	select {COLS}
	from @TBL_SCD4
    where {SOMECOL} is not null;

	select @@ROWCOUNT;
END TRY
BEGIN CATCH
    THROW
END CATCH
