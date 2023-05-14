CREATE PROCEDURE {TARGET_SCHEMA}.dim_{SRC_TABLE}_SCD3_ETL 
AS  
	MERGE  [{TARGET_DB}].[{TARGET_SCHEMA}].[{TARGET_TABLE}] AS DST
	USING [{SRC_DB}].[{SRC_SCHEMA}].[{SRC_TABLE}] AS SRC
	ON (SRC.{PKEY} = DST.{PKEY})
	WHEN NOT MATCHED THEN
		INSERT (
			{COLS}
		)
		VALUES (
			{SRC_COLS}
        )
	WHEN MATCHED  -- there can be only one matched case
	AND (
		{NULLDIFFS}
	)
	THEN 
		UPDATE SET  
			{UPDATES},
			DST.Previous{COL} = (CASE WHEN DST.{COL} <> SRC.{COL} THEN DST.{COL} ELSE DST.Previous{COL} END);
