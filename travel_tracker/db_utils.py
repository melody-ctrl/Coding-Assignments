import mysql.connector
from config import db_config
from mysql.connector import IntegrityError

# connection factory 
def get_connection():
    return mysql.connector.connect(**db_config)

# Create a trip (POST)
def create_trip(data):
    try:
        with get_connection() as db:
            cursor = db.cursor()

            query = """
            INSERT INTO trips (destination, start_date, end_date, budget, booked)
            VALUES (%s, %s, %s, %s, %s)
            """
            
            values = (
                data.get("destination"),
                data.get("start_date"),
                data.get("end_date"),
                data.get("budget"),
                data.get("booked", True)  # fallback
            )

            cursor.execute(query, values)
            print("Data inserted")

            db.commit()

            last_id = cursor.lastrowid
            print("New user ID: ", last_id)

            return {
                "message": "Trip created",
                "trip_id": last_id
            }, 201


    except IntegrityError as e:
        return {"Error. Invalid input": str(e)}, 400
    
    except Exception as e:
        return {"Error": str(e)}, 500


# Show all trips (GET)
def get_all_trips():
    try:
        with get_connection() as db:
            cursor = db.cursor(dictionary=True)

            cursor.execute("SELECT * FROM trips")
            results = cursor.fetchall() # used when call brings multiple lines 

            return results

    except Exception as e:
        return {"error": str(e)}


# Update a trip (PUT)
def update_trip(trip_id, data):
    try:
        with get_connection() as db:
            cursor = db.cursor()

            query = """
            UPDATE trips
            SET destination = %s,
                start_date = %s,
                end_date = %s,
                budget = %s,
                booked = %s
            WHERE trip_id = %s
            """

            values = (
                data.get("destination"),
                data.get("start_date"),
                data.get("end_date"),
                data.get("budget"),
                data.get("booked", True),
                trip_id
            )

            cursor.execute(query, values)
            db.commit()

            # check if anything was updated 
            if cursor.rowcount == 0:
                return {"error": "Trip not found"}, 404

            return {"message": "Trip updated"}, 200

    except Exception as e:
        return {"error": str(e)}, 500