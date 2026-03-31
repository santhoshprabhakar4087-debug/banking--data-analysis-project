from flask import Flask, jsonify
import pandas as pd
from db_connection import get_connection

app = Flask(__name__)
conn = get_connection()

@app.route('/orders')
def get_orders():
    df = pd.read_sql("SELECT * FROM Orders", conn)
    return jsonify(df.to_dict(orient='records'))

app.run(debug=True)