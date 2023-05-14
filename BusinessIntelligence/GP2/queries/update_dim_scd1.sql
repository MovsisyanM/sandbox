CREATE PROCEDURE {TARGET_SCHEMA}.dim_{SRC_TABLE}_SCD1_ETL
AS
BEGIN TRY
    MERGE [{TARGET_DB}].[{TARGET_SCHEMA}].[{TARGET_TABLE}] AS TARGET
    USING [{SRC_DB}].[{SRC_SCHEMA}].[{SRC_TABLE}] AS SOURCE 
    ON (TARGET.[{COL}] = SOURCE.[{COL}]) 
    --When records are matched, update the records if there is any change
    WHEN MATCHED 
        AND {MATCHING_CONDITIONS}
    THEN UPDATE SET 
        {UPDATES} 
    --When no records are matched, insert the incoming records from source table to target table
    WHEN NOT MATCHED {DEL_P1} 
    THEN 
        INSERT ({COLUMNS}) 
        VALUES ({SRC_COLUMNS})
    {DEL_P2}
    --$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
    --one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
    OUTPUT $action, 
        {DELETEDS} 
        {INSERTEDS}
    SELECT @@ROWCOUNT;
END TRY
BEGIN CATCH
    THROW
END CATCH