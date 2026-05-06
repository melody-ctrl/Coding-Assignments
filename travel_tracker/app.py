from flask import Flask, request, jsonify
from travel_tracker.db_utils import create_trip, get_all_trips, update_trip

app = Flask(__name__)

# Create a trip
@app.route("/trips", methods=["POST"])
def create_trip_route():
    print("Creating new trip...")
    try:
        # JSON data sent from client (main.py)
        data = request.get_json()

        if not data:
            return jsonify({"error": "No data provided"}), 400

        required_fields = ["destination", "start_date", "end_date", "budget", "booked"] #"booked" field not required as is already default

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
    
    
# Retrieve all trips 
@app.route("/trips", methods=["GET"]) # although it's default, writing to be clear
def get_trips_route():
    print("Retrieving all logged trips")

    result = get_all_trips()
    return jsonify(result)


# Update a trip completely 
@app.route("/trips/<int:trip_id>", methods=["PUT"])
def update_trip_route(trip_id):
    print(f"Updating trip with ID: {trip_id}")

    try:
        data = request.get_json()

        # check request body exists
        if not data:
            return jsonify({"error": "No data provided"}), 400

        # required fields for full update (every field changed)
        required_fields = ["destination", "start_date", "end_date", "budget", "booked"]

        # validate all fields exist
        for field in required_fields:
            if field not in data:
                return jsonify({
                    "error": f"Missing field: {field}"
                }), 400

        # call database function
        result, status = update_trip(trip_id, data)

        return jsonify(result), status

    except Exception as e:
        return jsonify({
            "error": "Invalid request",
            "details": str(e)
        }), 400
    
if __name__ == "__main__":
    app.run()