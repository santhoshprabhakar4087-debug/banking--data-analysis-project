import pandas as pd
from db_connection import get_connection

conn = get_connection()

query = "SELECT * FROM Orders"
df = pd.read_sql(query, conn)

print(df.head())