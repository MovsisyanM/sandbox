# Import the necessary modules
import openpyxl
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
    #tasks.insert_into_table(conn_ER, 'employees', 'Orders_RELATIONAL_DB', 'dbo', 'raw_data_source.xlsx', 'Employees')
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
    # conn_Dim = tasks.connect_db_create_cursor("Database2")
    # tasks.drop_table(conn_Dim, 'dim_people_scd1', 'Orders_DW', 'dbo')
    # tasks.create_table(conn_Dim, 'dim_people_scd1', 'Orders_DW', 'dbo')
    # tasks.update_dim_table(conn_Dim, 'dim_people_scd1', 'Orders_DW', 'dbo',
    #                        'people', 'Orders_ER', 'dbo')

    # conn_Dim.close()