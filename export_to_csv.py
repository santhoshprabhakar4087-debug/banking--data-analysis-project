import pandas as pd
from db_connection import get_connection

# DB connect
conn = get_connection()

# Query run
query = """
SELECT * FROM Orders
"""

df = pd.read_sql(query, conn)

# Export to CSV
df.to_csv("data/sales_data.csv", index=False)

print("CSV file created successfully!")