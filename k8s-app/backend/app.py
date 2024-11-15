# Flask application
from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

@app.route("/")
def index():
    return jsonify({"message": "Hello from Flask!"})

@app.route("/data")
def data():
    try:
        connection = mysql.connector.connect(
            host="mysql-service", user="root", password="rootpassword", database="testdb"
        )
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM sample;")
        result = cursor.fetchall()
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)})
    finally:
        if connection:
            connection.close()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
