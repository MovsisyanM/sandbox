import configparser

# Util to read the configuration file
def get_sql_config(filename, database):
     cf = configparser.ConfigParser ()
     cf.read (filename) #Read configuration file
     # Read corresponding file parameters
     _driver = cf.get(database,"DRIVER")
     _server = cf.get(database,"Server")
     _database = cf.get(database,"Database")
     _trusted_connection = cf.get(database,"Trusted_Connection")
     return _driver, _server,_database,_trusted_connection

# Extract the tables names of the database (excluding system tables)
def extract_tables_db(cursor, *args):
    results = []
    for x in cursor.execute('exec sp_tables'):
        if x[1] not in args:
            results.append(x[2])
    return results

# Extract the column names of a table given it's name
def extract_table_cols(cursor, table_name):
    result = []
    for row in cursor.columns(table=table_name):
        result.append(row.column_name)
    return result


# A function for finding the primary key of a table
def find_primary_key(cursor, table_name, schema):
    # Find the primary key information
    table_primary_key = cursor.primaryKeys(table_name, schema=schema)

    # Store the info about the PK constraint into a dictionary
    columns = [column[0] for column in cursor.description]
    results = []
    for row in cursor.fetchall():
        results.append(dict(zip(columns, row)))
    try:
        return results[0]
    except:
        pass
    return results