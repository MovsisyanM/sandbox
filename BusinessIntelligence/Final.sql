-- CREATING THE SOURCE TABLE
DROP TABLE IF EXISTS [dbo].[Customer];
GO 
CREATE TABLE [dbo].[Customer](
 [id] [int] IDENTITY(1,1) NOT NULL,
 [customer_name] [varchar](150) NULL,
 [country] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
	([ID] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY];
GO
-- POPULATING THE SOURCE TABLE
INSERT [dbo].[Customer] ([customer_name], [country]) VALUES ('John Smith', 'UK')
INSERT [dbo].[Customer] ([customer_name], [country]) VALUES ('Bauhaus Motors', 'UK')
INSERT [dbo].[Customer] ([customer_name], [country]) VALUES ('Honest Fred', 'UK')
INSERT [dbo].[Customer] ([customer_name], [country]) VALUES ('Fast Eddie', 'Wales')
INSERT [dbo].[Customer] ([customer_name], [country]) VALUES ('Slow Sid', 'France')
GO
-- CREATING THE DESTINATION TABLE 
DROP TABLE IF EXISTS [dbo].[Customer_SCD1];
GO
CREATE TABLE [dbo].[Customer_SCD1](
 [client_id_sk] [int] IDENTITY(1,1) NOT NULL,
 [business_key_nk] [int] NOT NULL,
 [customer_name] [varchar](150) NULL,
 [country] [varchar](50) NULL,
 [deleted_flg] [varchar](50) NULL) -- a column for pointing out deleted customers
;

-- SCD1
-- SET IDENTITY_INSERT customer_scd1 ON;
GO

MERGE dbo.customer_scd1 AS DST
USING dbo.customer AS SRC
ON ( SRC.id = DST.client_id_sk )
WHEN NOT MATCHED THEN
  INSERT (business_key_nk,customer_name,country)
  VALUES (SRC.id,SRC.customer_name,SRC.country)
WHEN MATCHED AND (DST.customer_name<> SRC.customer_name OR
	DST.country <> SRC.country) 
	THEN
		UPDATE SET DST.customer_name = SRC.customer_name,
             DST.country = SRC.country;


-- del flag
go

CREATE TRIGGER trg_Customer_SCD1_Delete
ON dbo.Customer_SCD1
INSTEAD OF DELETE
AS
BEGIN
    UPDATE cs
    SET deleted_flg = 'Y'
    FROM dbo.Customer_SCD1 AS cs
    INNER JOIN deleted AS d ON cs.business_key_nk = d.business_key_nk;
END;

go

CREATE PROCEDURE dbo.DeleteCustomer_SCD1
    @business_key_nk INT
AS
BEGIN
    DELETE FROM dbo.Customer_SCD1
    WHERE business_key_nk = @business_key_nk;
END;

go


select * from dbo.Customer_SCD1

exec dbo.DeleteCustomer_SCD1 1