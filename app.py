from flask import Flask, request, jsonify
from db_utils import create_trip

app = Flask(__name__)

@app.route("/trips", methods=["POST"])
def create_trip_route():
    print("Creating new trip...")
    data = request.get_json()

    result, status = create_trip(data)

    return jsonify(result), status