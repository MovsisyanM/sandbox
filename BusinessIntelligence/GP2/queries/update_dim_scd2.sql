CREATE PROCEDURE {TARGET_SCHEMA}.dim_{SRC_TABLE}_SCD2_ETL
AS
BEGIN
    SET NOCOUNT ON;

    -- Define the dates used in validity - assume whole 24 hour cycles
    DECLARE @Yesterday INT =  --20210412 = 2021 * 10000 + 4 * 100 + 12
    (
    YEAR(DATEADD(dd, - 1, GETDATE())) * 10000
    )
    + (MONTH(DATEADD(dd, - 1, GETDATE())) * 100) + DAY(DATEADD(dd, - 1, GETDATE())) 
    DECLARE @Today INT = --20210413 = 2021 * 10000 + 4 * 100 + 13
    (
    YEAR(GETDATE()) * 10000
    )
    + (MONTH(GETDATE()) * 100) + DAY(GETDATE()); 

    -- Create staging table
    IF OBJECT_ID('tempdb..#{TARGET_TABLE}_Staging') IS NOT NULL
        DROP TABLE #{TARGET_TABLE}_Staging;

    CREATE TABLE #{TARGET_TABLE}_Staging (
        {TBL_DEF},
        MergeAction VARCHAR(10) NOT NULL
    );

    -- Merge data into staging table
    MERGE INTO #{TARGET_TABLE}_Staging AS DST
    USING (
        SELECT {COLS}, 'UPDATE' AS MergeAction
        FROM {SRC_DB}.{SRC_SCHEMA}.{SRC_TABLE}
    ) AS SRC
    ON (SRC.{PKEY} = DST.{PKEY})
    WHEN NOT MATCHED THEN
        INSERT ({COLS}, MergeAction)
        VALUES ({SRC_COLS}, 'INSERT')
    WHEN MATCHED AND (
        {NULLDIFFS}
    ) THEN
        UPDATE SET MergeAction = 'UPDATE';

    -- Update existing records in target table
    UPDATE D
    SET IsCurrent = 0, ValidTo = @Yesterday
    FROM {TARGET_DB}.{TARGET_SCHEMA}.{TARGET_TABLE} AS D
    INNER JOIN #{TARGET_TABLE}_Staging AS S
    ON (D.{PKEY} = S.{PKEY} AND S.MergeAction = 'UPDATE' AND D.IsCurrent = 1);

    -- Insert new records into target table
    INSERT INTO {TARGET_DB}.{TARGET_SCHEMA}.{TARGET_TABLE} (
        {COLS}, ValidFrom, IsCurrent
    )
    SELECT {COLS}, @Today, 1
    FROM #{TARGET_TABLE}_Staging
    WHERE MergeAction = 'INSERT';

    DROP TABLE #{TARGET_TABLE}_Staging;
END;