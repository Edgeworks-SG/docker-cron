import pyodbc

# Specifying the ODBC driver, server name, database, etc. directly
conn = pyodbc.connect('DRIVER={ODBC Driver 18 for SQL Server};SERVER=host.docker.internal;UID=sa;PWD=1Secure*Password1;TrustServerCertificate=yes;')

# Create a cursor from the connection
cursor = conn.cursor()

cursor.execute("SELECT @@version")
row = cursor.fetchone()
print(row[0])