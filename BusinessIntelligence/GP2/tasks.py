import config
import os
import pandas as pd
import pyodbc
import utils
import numpy as np
import openpyxl


def connect_db_create_cursor(database_conf_name):
    # Call to read the configuration file
    db_conf = utils.get_sql_config(config.sql_server_config, database_conf_name)
    # Create a connection string for SQL Server
    db_conn_str = 'Driver={};Server={};Database={};Trusted_Connection={};'.format(*db_conf)
    # Connect to the server and to the desired database
    db_conn = pyodbc.connect(db_conn_str)
    # Create a Cursor class instance for executing T-SQL statements
    db_cursor = db_conn.cursor()
    return db_cursor


def load_query(query_name):
    sql_script = ""
    for script in os.listdir(config.input_dir):
        if query_name in script:
            with open(config.input_dir + '\\' + script, 'r') as script_file:
                sql_script = script_file.read()
            break
    return sql_script


def drop_table(cursor, table_name, db, schema):
    drop_table_script = load_query('drop_table').format(db=db, schema=schema, table=table_name)
    cursor.execute(drop_table_script)
    cursor.commit()
    print("The {schema}.{table_name} table from the database {db} has been dropped".format(db=db, schema=schema,
                                                                                       table_name=table_name))


# create_table_script = load_query('create_table_{}'.format('Categories')).format(db='Orders_RELATIONAL_DB', schema='dbo')
# print(create_table_script)

def create_table(cursor, table_name, db, schema, **kwargs):
    create_table_script = ""
    print("DEBUG")
    print(os.listdir("queries"))
    if 'create_table_{}.sql'.format(table_name) in os.listdir("queries"):
        create_table_script += load_query('create_table_{}'.format(table_name)).format(db=db, schema=schema)
    else:
        create_table_script += define_tbl(name=table_name, db=db, schema=schema, **kwargs)
    print(create_table_script)
    cursor.execute(create_table_script)
    cursor.commit()
    
    print("The {schema}.{table_name} table from the database {db} has been created".format(db=db, schema=schema,
                                                                                           table_name=table_name))


# print("The {schema}.{table_name} table from the database {db} has been created".format(db=Orders_RELATIONAL_DB, schema=dbo,table_name=Categories))

def insert_into_table(cursor, table_name, db, schema, source_data, sheet_name):
    # Read the excel sheet
    df = pd.read_excel(source_data, sheet_name=sheet_name, header=0)

    # Convert all columns except ShippedDate to string data type
    for col in df.columns:
        if col not in ['ShippedDate', 'EmployeeID', 'ReportsTo']:
            df[col] = df[col].astype(str)

    # Convert all columns except ShippedDate and ReportsTo to string data type

    if sheet_name == 'Employees':
        df = df.astype(object).where(pd.notnull(df), None)
        df['EmployeeID'] = df['EmployeeID'].astype(int)
        df['ReportsTo'] = df['ReportsTo'].astype(int, errors='ignore')
        # df = df.where(pd.notnull(df), None)
        df = df.sort_values('ReportsTo', na_position='first')

    # print(df)

    insert_into_table_script = load_query('insert_into_{}'.format(table_name)).format(db=db, schema=schema)
    # print(insert_into_table_script)
    # Populate a table in sql server

    for index, row in df.iterrows():
        if sheet_name == 'Categories':
            cursor.execute(insert_into_table_script, row['CategoryID'], row['CategoryName'], row['Description'])
        elif sheet_name == 'Shippers':
            cursor.execute(insert_into_table_script, row['ShipperID'], row['CompanyName'], row['Phone'])
        elif sheet_name == 'Region':
            cursor.execute(insert_into_table_script, row['RegionID'], row['RegionDescription'])
        elif sheet_name == 'Territories':
            cursor.execute(insert_into_table_script, row['TerritoryID'], row['TerritoryDescription'], row['RegionID'])
        elif sheet_name == 'Customers':
            cursor.execute(insert_into_table_script, row['CustomerID'],
                           row['CompanyName'],
                           row['ContactName'],
                           row['ContactTitle'], row['Address'], row['City'], row['Region'], row['PostalCode'],
                           row['Country'], row['Phone'], row['Fax'])
        elif sheet_name == 'Suppliers':
            cursor.execute(insert_into_table_script, row['SupplierID'], row['CompanyName'], row['ContactName'],
                           row['ContactTitle'], row['Address'], row['City'], row['Region'], row['PostalCode'],
                           row['Country'], row['Phone'], row['Fax'], row['HomePage'])
        elif sheet_name == 'Employees':
            cursor.execute(insert_into_table_script, row['EmployeeID'], row['LastName'], row['FirstName'],
                           row['Title'], row['TitleOfCourtesy'], row['BirthDate'], row['HireDate'], row['Address'],
                           row['City'], row['Region'], row['PostalCode'], row['Country'], row['HomePhone'],
                           row['Extension'], row['Notes'], row['ReportsTo'], row['PhotoPath'])
        elif sheet_name == 'Products':
            cursor.execute(insert_into_table_script, row['ProductID'], row['ProductName'], row['SupplierID'],
                           row['CategoryID'], row['QuantityPerUnit'], row['UnitPrice'], row['UnitsInStock'], row['UnitsOnOrder'],
                           row['ReorderLevel'], row['Discontinued'])
        elif sheet_name == 'Orders':
            cursor.execute(insert_into_table_script, row['OrderID'], row['CustomerID'], row['EmployeeID'],
                           row['OrderDate'], row['RequiredDate'], row['ShippedDate'], row['ShipVia'], row['Freight'],
                           row['ShipName'], row['ShipAddress'], row['ShipCity'], row['ShipRegion'], row['ShipPostalCode'],
                           row['ShipCountry'], row['TerritoryID'])
        elif sheet_name == 'OrderDetails':
            cursor.execute(insert_into_table_script, row['OrderID'], row['ProductID'], row['UnitPrice'],
                           row['Quantity'], row['Discount'])
        else:
            raise ValueError("Unsupported sheet name")

    cursor.commit()

    print(f"{len(df)} rows have been inserted into the {db}.{schema}.{table_name} table from sheet {sheet_name}")


def update_dim_table(cursor, table_dst, db_dst, schema_dst, table_src, db_src, schema_src):

    update_table_script = load_query('update_table_{}'.format(table_dst)).format(
        db_dim=db_dst, schema_dim=schema_dst, table_dim=table_dst,
        db_rel=db_src, schema_rel=schema_src, table_rel=table_src)

    # Execute the query
    cursor.execute(update_table_script)
    cursor.commit()

    print(f"The dimension table {table_dst} has been updated.")


# region Task 2

extract_columns = lambda x: [i.split("[")[1].split("]")[0] for i in x.split("\n") if "[" in i]

relational_tbl_defs = {
    "Suppliers": """[SupplierID] INT primary key
		,[CompanyName] VARCHAR(100)
		,[ContactName] VARCHAR(100)
		,[ContactTitle] VARCHAR(100)
		,[Address] VARCHAR(100)
		,[City] VARCHAR(50)
		,[Region] VARCHAR(50) NULL
		,[PostalCode] VARCHAR(50)
		,[Country] VARCHAR(50)
		,[Phone] VARCHAR(50)
		,[Fax] VARCHAR(50) NULL
		,[HomePage] VARCHAR(150) NULL""",

    "categories": """[CategoryID] INT primary key
	,[CategoryName] VARCHAR(50)
	,[Description] VARCHAR(150)""",

    "customers": """[CustomerID] CHAR(100) primary key
	,[CompanyName] VARCHAR(150)
	,[ContactName] VARCHAR(50)
    ,[ContactTitle] VARCHAR(50)
    ,[Address] VARCHAR(50)
    ,[City] VARCHAR(50)
    ,[Region] VARCHAR(50) NULL
    ,[PostalCode] VARCHAR(50) NULL
    ,[Country] VARCHAR(100)
    ,[Phone] VARCHAR(100)
    ,[Fax] VARCHAR(100) NULL""",

    "employees":"""[EmployeeID] INT primary key
   ,[LastName] VARCHAR(150)
   ,[FirstName] VARCHAR(50)
    ,[Title] VARCHAR(50)
    ,[TitleOfCourtesy] VARCHAR(50)
    ,[BirthDate] DATE
    ,[HireDate] DATE
    ,[Address] VARCHAR(100)
    ,[City] VARCHAR(50)
    ,[Region] VARCHAR(50) NULL
    ,[PostalCode] VARCHAR(50)
    ,[Country] VARCHAR(50)
    ,[HomePhone] VARCHAR(100)
    ,[Extension] INT
    ,[Notes] VARCHAR(500)
    ,[ReportsTo] INT NULL
    ,[PhotoPath] VARCHAR(200)
    ,CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES {db}.{schema}.{Employees_TBL_NAME} (EmployeeID)""",

    "OrderDetails": """[OrderID] INT primary key
	,[ProductID] INT 
	,[UnitPrice] FLOAT(38)
    ,[Quantity] INT
    ,[Discount] FLOAT(38)
    ,CONSTRAINT FK_Orders_OrderID FOREIGN KEY (OrderID) REFERENCES {db}.{schema}.{Orders_TBL_NAME} (OrderID)
    ,CONSTRAINT FK_Products_ProductID FOREIGN KEY (ProductID) REFERENCES {db}.{schema}.{Products_TBL_NAME} (ProductID)""",

    "Orders":"""[OrderID] INT primary key
	,[CustomerID] CHAR(100)
	,[EmployeeID] INT
	,[OrderDate] DATE
	,[RequiredDate] DATE
	,[ShippedDate] DATE NULL
	,[ShipVia] INT
	,[Freight] FLOAT(38)
	,[ShipName] VARCHAR(100)
	,[ShipAddress] VARCHAR(100)
	,[ShipCity] VARCHAR(50)
	,[ShipRegion] VARCHAR(50) NULL
	,[ShipPostalCode] VARCHAR(50)
	,[ShipCountry] VARCHAR(50)
	,[TerritoryID] INT
    ,CONSTRAINT FK_Customers_CustomerID FOREIGN KEY (CustomerID) REFERENCES {db}.{schema}.{Customers_TBL_NAME} (CustomerID)
    ,CONSTRAINT FK_Employees_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES {db}.{schema}.{Employees_TBL_NAME} (EmployeeID)
    ,CONSTRAINT FK_Shippers_ShipVia FOREIGN KEY (ShipVia) REFERENCES {db}.{schema}.{Shippers_TBL_NAME} (ShipperID)
    ,CONSTRAINT FK_Territories_TerritoryID FOREIGN KEY (TerritoryID) REFERENCES {db}.{schema}.{Territories_TBL_NAME} (TerritoryID)""",

    "People":"""[BusinessEntityID] INT primary key
	,[FirstName] VARCHAR(50)
	,[LastName] VARCHAR(100)""",

    "Products":"""[ProductID] INT primary key
	,[ProductName] VARCHAR(100)
	,[SupplierID] INT
	,[CategoryID] INT
	,[QuantityPerUnit] VARCHAR(100)
	,[UnitPrice] FLOAT(38)
	,[UnitsInStock] INT
	,[UnitsOnOrder] INT
	,[ReorderLevel] INT
	,[Discontinued] VARCHAR(15)
    ,CONSTRAINT FK_Categories_CategoryID FOREIGN KEY (CategoryID) REFERENCES {db}.{schema}.{Categories_TBL_NAME} (CategoryID)
	,CONSTRAINT FK_Suppliers_SupplierID FOREIGN KEY (SupplierID) REFERENCES {db}.{schema}.{Suppliers_TBL_NAME} (SupplierID)""",

    "Region":"""[RegionID] INT primary key
	,[RegionDescription] VARCHAR(50)""",

    "Shippers":"""[ShipperID] INT primary key
	,[CompanyName] VARCHAR(100)
	,[Phone] VARCHAR(50)""",

    "Territories":"""[TerritoryID] INT primary key
	,[TerritoryDescription] VARCHAR(50)
	,[RegionID] INT
    ,CONSTRAINT FK_Regions_RegionID FOREIGN KEY (RegionID) REFERENCES {db}.{schema}.{Region_TBL_NAME} (RegionID)"""
}

for key, val in relational_tbl_defs.items():
    relational_tbl_defs[key] = val\
        .replace("{Region_TBL_NAME}", "DimRegion")\
        .replace("{Suppliers_TBL_NAME}", "DimSuppliers")\
        .replace("{Categories_TBL_NAME}", "DimCategories")\
        .replace("{Territories_TBL_NAME}", "DimTerritories")\
        .replace("{Shippers_TBL_NAME}", "DimShippers")\
        .replace("{Employees_TBL_NAME}", "DimEmployees")\
        .replace("{Orders_TBL_NAME}", "FactOrders")\
        .replace("{Products_TBL_NAME}", "DimProducts")\
        .replace("{Customers_TBL_NAME}", "DimCustomers")

SCD_Templates = {}

for i in range(4):
    with open(f"queries/update_dim_scd{i+1}.sql", "r") as f:
        SCD_Templates[f"scd{i+1}"] = f.read()

def gen_SCD1_ETL(
        include_delete, 
        target_db, 
        target_schema, 
        target_tbl,
        src_db, 
        src_schema, 
        src_tbl, **kwargs
        ):
    match_conds = "(\n\t\t" + \
        " or \n\t\t".join([f"ISNULL(TARGET.{col}, '') <> ISNULL(SOURCE.{col}, '')" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]]) + \
    "\n\t)"
    updates = ",\n\t".join([f"TARGET.{col} = SOURCE.{col}" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]])
    columns = ", ".join(extract_columns(relational_tbl_defs[src_tbl]))
    src_columns = ", ".join(["SOURCE." + i for i in extract_columns(relational_tbl_defs[src_tbl])])
    del_p1 = "BY TARGET" if include_delete else ""
    del_p2 = """
    --When there is a row that exists in target and same record does not exist in source then delete this record target
    WHEN NOT MATCHED BY SOURCE
        THEN DELETE""" if include_delete else ""
    delled_cols = ",\n\t\t".join([f"DELETED.{col} AS Target{col}" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]]) + ","
    inserted_cols = ",\n\t\t".join([f"INSERTED.{col} AS Source{col}" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]]) + ";"

    return SCD_Templates["scd1"]\
        .replace("{TARGET_DB}", target_db)\
        .replace("{TARGET_TABLE}", target_tbl)\
        .replace("{SRC_TABLE}", src_tbl)\
        .replace("{TARGET_SCHEMA}", target_schema)\
        .replace("{SRC_DB}", src_db)\
        .replace("{SRC_SCHEMA}", src_schema)\
        .replace("{MATCHING_CONDITIONS}", match_conds)\
        .replace("{UPDATES}", updates)\
        .replace("{COLUMNS}", columns)\
        .replace("{SRC_COLUMNS}", src_columns)\
        .replace("{DEL_P1}", del_p1)\
        .replace("{DEL_P2}", del_p2)\
        .replace("{COL}", extract_columns(relational_tbl_defs[src_tbl])[0])\
        .replace("{DELETEDS}", delled_cols)\
        .replace("{INSERTEDS}", inserted_cols)


def gen_SCD2_ETL(
        target_db, target_schema, target_tbl,
        src_db, src_schema, src_tbl, **kwargs
		):
    cols = ",\n\t\t".join(extract_columns(relational_tbl_defs[src_tbl]))
    src_cols = ",\n\t\t".join(["SRC." + col for col in extract_columns(relational_tbl_defs[src_tbl])])
    nulldiffs = " OR\n\t\t".join([f"Isnull(DST.{col}, '') <> Isnull(SRC.{col}, '')" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]])
    tbl_subdef = relational_tbl_defs[src_tbl]\
        .replace("{db}", target_db)\
        .replace("{schema}", target_schema)


    return SCD_Templates["scd2"]\
		.replace("{TARGET_DB}", target_db)\
		.replace("{TARGET_SCHEMA}", target_schema)\
		.replace("{TARGET_TABLE}", target_tbl)\
		.replace("{SRC_DB}", src_db)\
		.replace("{SRC_SCHEMA}", src_schema)\
		.replace("{SRC_TABLE}", src_tbl)\
		.replace("{COLS}", cols)\
		.replace("{SRC_COLS}", src_cols)\
		.replace("{NULLDIFFS}", nulldiffs)\
		.replace("{PKEY}", extract_columns(relational_tbl_defs[src_tbl])[0])\
        .replace("{TBL_DEF}", "\n".join([i for i in tbl_subdef.split("\n") if "]" in i]))


def gen_SCD3_ETL(
		target_db, target_schema, target_tbl,
        src_db, src_schema, src_tbl, col, **kwargs
		):
	cols = ",\n\t\t".join(extract_columns(relational_tbl_defs[src_tbl]))
	src_cols = ",\n\t\t".join(["SRC." + col for col in extract_columns(relational_tbl_defs[src_tbl])])
	nulldiffs = " OR\n\t\t".join([f"Isnull(DST.{col}, '') <> Isnull(SRC.{col}, '')" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]])
	updates = ",\n\t".join([f"DST.{col} = SRC.{col}" for col in extract_columns(relational_tbl_defs[src_tbl])[1:]])

	return SCD_Templates["scd3"]\
		.replace("{TARGET_DB}", target_db)\
		.replace("{TARGET_SCHEMA}", target_schema)\
		.replace("{TARGET_TABLE}", target_tbl)\
		.replace("{SRC_DB}", src_db)\
		.replace("{SRC_SCHEMA}", src_schema)\
		.replace("{SRC_TABLE}", src_tbl)\
		.replace("{COLS}", cols)\
		.replace("{SRC_COLS}", src_cols)\
		.replace("{NULLDIFFS}", nulldiffs)\
		.replace("{UPDATES}", updates)\
		.replace("{PKEY}", extract_columns(relational_tbl_defs[src_tbl])[0])\
		.replace("{COL}", col)


def gen_SCD4_ETL(
        target_db, target_schema, target_tbl,
		src_db, src_schema, src_tbl, **kwargs
    	):
	col_list = extract_columns(relational_tbl_defs[src_tbl])
	cols = ",\n\t\t".join(col_list)
	src_cols = ",\n\t\t".join(["SRC." + col for col in col_list])
	nulldiffs = " OR\n\t\t".join([f"Isnull(DST.{col}, '') <> Isnull(SRC.{col}, '')" for col in col_list[1:]])
	updates = ",\n\t".join([f"DST.{col} = SRC.{col}" for col in col_list[1:]])
	delleds = ",\n\t\t".join(["DELETED." + col for col in col_list[1:]])
	tbl_subdef = relational_tbl_defs[src_tbl]\
		.replace("{db}", target_db)\
		.replace("{schema}", target_schema)

	return SCD_Templates["scd4"]\
		.replace("{TARGET_DB}", target_db)\
		.replace("{TARGET_SCHEMA}", target_schema)\
		.replace("{TARGET_TABLE}", target_tbl)\
		.replace("{SRC_DB}", src_db)\
		.replace("{SRC_SCHEMA}", src_schema)\
		.replace("{SRC_TABLE}", src_tbl)\
		.replace("{COLS}", cols)\
		.replace("{SRC_COLS}", src_cols)\
		.replace("{NULLDIFFS}", nulldiffs)\
		.replace("{UPDATEDS}", updates)\
		.replace("{PKEY}", col_list[0])\
		.replace("{SOMECOL}", col_list[1])\
		.replace("{TBL_DEF}", "\n".join([i for i in tbl_subdef.split("\n") if "]" in i]))\
		.replace("{DELLEDS}", delleds)


def define_tbl(name, relational_name, db, schema, scd_type, **kwargs):
    tbl_subdef = relational_tbl_defs[relational_name]\
		.replace("{db}", db)\
		.replace("{schema}", schema)
    
    tbl_def = f"create table [{db}].[{schema}].[{name}] (\n"
    tbl_def += "\t" + extract_columns(relational_tbl_defs[relational_name])[0] + \
        "_PK_SK int identity(1, 1) not null,\n\t"
    tbl_def += tbl_subdef + "\n"
    if scd_type == "scd2":
        tbl_def += "\t,ValidFrom int\n"
        tbl_def += "\t,ValidTo int null\n"
        tbl_def += "\t,IsCurrent smallint\n"
    elif scd_type == "scd3":
        assert "col" in kwargs.keys(), "ERROR: No `col` specified for SCD3 versioning."    
        tbl_def += "\t,Previous" + (kwargs["col"] + \
            (type_definition := [i for i in relational_tbl_defs[relational_name].split("\n") if (
                (kwargs["col"] in i) and ("]" in i))][0].split("]")[1])) + \
                    (" null" if "null" not in type_definition else "") + "\n"
    tbl_def += ");\n\n"
    
    if scd_type == "scd4":
        tbl_def += f"create table [{db}].[{schema}].[{name}_History] (\n\t"
        tbl_def += "\t" + extract_columns(relational_tbl_defs[relational_name])[0] + \
            "_PK_SK int identity(1, 1) not null,\n\t"
        tbl_def += "\n".join([i if "]" in i else (i.split(" FOREIGN KEY")[0] + "_History FOREIGN KEY" + \
                                        i.split(" FOREIGN KEY")[1]) for i in tbl_subdef.split("\n")])
        tbl_def += ");\n\n"

    return tbl_def


def gen_ETL(target_db, target_schema, target_tbl, src_db, src_schema, src_tbl, scd_type, **kwargs):
    """scd_type:
        one of ['scd1d', 'scd1', 'scd2', 'scd3', 'scd4']"""
    
    assert scd_type in ['scd1d', 'scd1', 'scd2', 'scd3', 'scd4'], "scd_type needs to be \
                one of ['scd1d', 'scd1', 'scd2', 'scd3', 'scd4']"
    all_kwargs = dict(
        target_db=target_db, 
        target_schema=target_schema, 
        target_tbl=target_tbl, 
        src_db=src_db, 
        src_schema=src_schema, 
        src_tbl=src_tbl,
        **kwargs
        )
    
    if scd_type == "scd1d":
        return gen_SCD1_ETL(
            True, 
            **all_kwargs
        )
    elif scd_type == "scd1":
        return gen_SCD1_ETL(
            False, 
            **all_kwargs
        )
    elif scd_type == "scd2":
        return gen_SCD2_ETL(**all_kwargs)
    elif scd_type == "scd3":
        return gen_SCD3_ETL(**all_kwargs)
    elif scd_type == "scd4":
        return gen_SCD4_ETL(**all_kwargs)
    
    
    raise NotImplementedError("How did you get here?")


def execute_procedure(cursor, procedure_name):
    print((script := f"exec {procedure_name}"))
    cursor.execute(script)
    cursor.commit()
    print(f"Executed procedure {procedure_name}")

def define_ETL(cursor, etl_procedure, proc_name):
    print(etl_procedure)
    cursor.execute(etl_procedure)
    cursor.commit()
    print(f"Defined procedure {proc_name}")

def drop_procedure(cursor, procedure_name, schema):
    drop_table_script = load_query('drop_procedure').format(schema=schema, procedure=procedure_name)
    cursor.execute(drop_table_script)
    cursor.commit()
    print("The {schema}.{procedure_name} procedure has been dropped"\
          .format(schema=schema, procedure_name=procedure_name))
    
def drop_etl(cursor, tbl_name, schema, scd_type):
    drop_procedure(cursor, f"dim_{tbl_name}_{scd_type[:4].upper()}_ETL", schema)

def execute_etl(cursor, tbl_name, schema, scd_type):
    execute_procedure(cursor, f"{schema}.dim_{tbl_name}_{scd_type[:4].upper()}_ETL")

# endregion Task 2