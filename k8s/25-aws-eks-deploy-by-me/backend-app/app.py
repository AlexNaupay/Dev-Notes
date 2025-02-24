from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
import os

app = Flask(__name__)
CORS(app)

def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host=os.environ.get('DB_HOST'),
            database=os.environ.get('DB_NAME'),
            user=os.environ.get('DB_USER'),
            password=os.environ.get('DB_PASSWORD')
        )
        # ENV values are set in deployment manifest
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

@app.route('/get-info')
def getMyInfo():
    connection = get_db_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT * FROM user_info LIMIT 1")
            result = cursor.fetchone()

            if result:
                formatted_result = {
                    "name": result.get("name", ""),
                    "lastname": result.get("lastname", ""),
                    "socialMedia": {
                        "facebookUser": result.get("facebook_user", ""),
                        "instagramUser": result.get("instagram_user", ""),
                        "xUser": result.get("x_user", ""),
                        "linkedin": result.get("linkedin", ""),
                        "githubUser": result.get("github_user", "")
                    },
                    "blog": result.get("blog", ""),
                    "author": result.get("author", "")
                }
                return jsonify(formatted_result)
            else:
                return jsonify({
                    "error": "There is something wrong with this API"
                })
        except Error as e:
            print(f"Error executing query: {e}")
        finally:
            cursor.close()
            connection.close()

    return jsonify({"error": "Database connection failed"})

if __name__ == '__main__':
    app.run(port=5001)