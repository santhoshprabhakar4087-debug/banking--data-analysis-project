import pandas as pd
from db_connection import get_connection

conn = get_connection()

df = pd.read_sql("SELECT total_amout FROM Orders", conn)

print("Total Revenue:", df['total_amout'].sum())
print("Average Order:", df['total_amout'].mean())