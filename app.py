from flask import Flask, request, jsonify
from db_utils import create_trip

app = Flask(__name__)

@app.route("/trips", methods=["POST"])
def create_trip_route():
    print("Creating new trip...")
    try:
        # JSON data sent from client (main.py)
        data = request.get_json()

        if not data:
            return jsonify({"error": "No data provided"}), 400

        required_fields = ["destination", "start_date", "end_date", "budget"] #"booked" field not required as is already default

        # loop through required fields and check they're not empty 
        for field in required_fields:
            if not data.get(field):
                return jsonify({
                    "status": "error",
                    "message": f"Missing field: {field}"
                }), 400
            
        # call db_utils function to insert the trip
        result, status = create_trip(data)
        
        # send response back to client
        return jsonify(result), status
    
    except Exception as e:
        return jsonify({
            "error": "Invalid request",
            "details": str(e)
        }), 400