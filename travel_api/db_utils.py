import mysql.connector
from config import db_config

# connection factory 
def get_connection():
    return mysql.connector.connect(**db_config)

# Create a trip (POST)

def create_trip(data):
    try:
        with get_connection() as db:
            cursor = db.cursor()

            query = """
            INSERT INTO trips (destination, start_date, end_date, budget)
            VALUES (%s, %s, %s, %s)
            """

            values = (
                data.get("destination"),
                data.get("start_date"),
                data.get("end_date"),
                data.get("budget")
            )

            cursor.execute(query, values)
            db.commit()

            return {"message": "Trip created"}

    except Exception as e:
        return {"error": str(e)}




# Show all trips (GET)

# def get_all_trips():
#     try:
#         with get_connection() as db:
#             cursor = db.cursor(dictionary=True)

#             cursor.execute("SELECT * FROM trips")
#             results = cursor.fetchall() # used when call brings multiple lines 

#             return results

#     except Exception as e:
#         return {"error": str(e)}


# Update a trip status (POST)