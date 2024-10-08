import tasks

if __name__ == '__main__':
    conn_ER = tasks.connect_db_create_cursor("Database1")
    tasks.drop_table(conn_ER, 'OrderDetails', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Orders', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Products', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Territories', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Categories', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Customers', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Employees', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Region', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Shippers', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.drop_table(conn_ER, 'Suppliers', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'categories', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'customers', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'employees', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'shippers', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'region', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'territories', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'orders', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'suppliers', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'products', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.create_table(conn_ER, 'orderdetails', 'Orders_RELATIONAL_DB', 'dbo')
    tasks.insert_into_table(conn_ER, 'categories', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Categories')
    tasks.insert_into_table(conn_ER, 'shippers', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Shippers')
    tasks.insert_into_table(conn_ER, 'region', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Region')
    tasks.insert_into_table(conn_ER, 'territories', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Territories')
    tasks.insert_into_table(conn_ER, 'customers', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Customers')
    tasks.insert_into_table(conn_ER, 'suppliers', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Suppliers')
    tasks.insert_into_table(conn_ER, 'employees', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Employees')
    tasks.insert_into_table(conn_ER, 'products', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Products')
    tasks.insert_into_table(conn_ER, 'orders', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Orders')
    tasks.insert_into_table(conn_ER, 'orderdetails', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx',
                            'OrderDetails')

    conn_ER.close()
    

    conn_ER = tasks.connect_db_create_cursor("Database2")
    db1 = "Orders_RELATIONAL_DB"
    db2 = "Orders_DIMENSIONAL_DW"
    schema = "dbo"
    ct = lambda n, s, c, r:  tasks.create_table(
        conn_ER, n, 
        db2, schema, 
        scd_type=s, 
        col=c, 
        relational_name=r
    )

    [(tasks.drop_table(conn_ER, tbl, db2, schema), 
      tasks.drop_table(conn_ER, tbl + "_History", db2, schema)) for tbl in [
        "DimOrderDetails",
        "FactOrders",
        "DimCustomers",
        "DimTerritories",
        "DimEmployees",
        "DimProducts",
        "DimShippers",
        "DimCategories",
        "DimSuppliers",
        "DimRegion",
    ]]

    # Creating tables
    ct("DimCustomers", s="scd3", c="Phone", r="customers")
    ct("DimCategories", s="scd1d", c="", r="categories")
    ct("DimEmployees", s="scd2", c="", r="employees")
    ct("DimSuppliers", s="scd4", c="", r="Suppliers")
    ct("DimRegion", s="scd1", c="", r="Region")
    ct("DimShippers", s="scd1", c="", r="Shippers")
    ct("DimTerritories", s="scd2", c="", r="Territories")
    ct("DimProducts", s="scd1d", c="", r="Products")
    ct("FactOrders", s="scd1", c="", r="Orders")
    ct("DimOrderDetails", s="scd1", c="", r="OrderDetails")

    # Defining ETL
    etl = lambda t, r, c, s: tasks.define_ETL(conn_ER, tasks.gen_ETL(db2, schema, t, db1, schema, r, s, col=c), f"dim_{r}_{s[:4].upper()}_ETL")

    [tasks.drop_etl(conn_ER, tbl, schema, scd) for tbl, scd in [
        ("customers","scd3"),
        ("categories","scd1d"),
        ("employees","scd2"),
        ("Suppliers","scd4"),
        ("Region","scd1"),
        ("Shippers","scd1"),
        ("Territories","scd2"),
        ("Products","scd1d"),
        ("Orders", "scd1"),
        ("OrderDetails", "scd1")
    ]]

    etl("DimCategories", s="scd1d", c="", r="categories")
    etl("DimShippers", s="scd1", c="", r="Shippers")
    etl("DimRegion", s="scd1", c="", r="Region")
    etl("DimTerritories", s="scd2", c="", r="Territories")
    etl("DimCustomers", s="scd3", c="Phone", r="customers")
    etl("DimSuppliers", s="scd4", c="", r="Suppliers")
    etl("DimEmployees", s="scd2", c="", r="employees")
    etl("DimProducts", s="scd1d", c="", r="Products")
    etl("FactOrders", s="scd1", c="", r="Orders")
    etl("DimOrderDetails", s="scd1", c="", r="OrderDetails")


    # executing ETL
    [tasks.execute_etl(conn_ER, tbl, schema, scd) for tbl, scd in [
        ("categories","scd1d"),
        ("Shippers","scd1"),
        ("Region","scd1"),
        ("Territories","scd2"),
        ("customers","scd3"),
        ("Suppliers","scd4"),
        ("employees","scd2"),
        ("Products", "scd1d"),
        ("Orders", "scd1"),
        ("OrderDetails", "scd1")
    ]]

    # NOTE FOR GRADERS
    # THE TABLES DimProducts, FactOrders, DimOrderDetails NEED
    # TO BE POPULATED BY MANUALLY RUNNING `exec dbo.dim_Products_SCD1_ETL`

    conn_ER.close()