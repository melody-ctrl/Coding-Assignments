import requests 

# API parameters
URL = "http://127.0.0.1:5000"


#POST 
def create_trip():
    print("Hello, welcome back to your travel tracker. Let's track a new trip...")
        
    new_trip = {
        "destination": "Tanzania",
        "start_date": "2026-09-07",
        "end_date": "2026-09-27",
        "budget": 2000,
        "booked": True
        }

    try:  
        response = requests.post(f"{URL}/trips", json=new_trip)
        
        print(response.status_code) # seeing if our post request worked 
        data = response.json() 
        
        print(data)
        
        if response.status_code == 201: # not error handling, just telling code how to react
            print("Your new trip has been created successfully!")
        else: 
            print("There was an error creating your trip. Please try again.")
    
    except requests.exceptions.RequestException as e: # for crashes, before rest of above code can even run 
        print(f"Request failed: {e}")


# GET
def get_all_trips():
    print("Hello, welcome back to your travel tracker. Retrieving all your trips...")
    try:
        response = requests.get(f"{URL}/trips")
        print(response.status_code)

        data = response.json()

        print("Here are your trips: ", data)

    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")


# PUT
def update_trip(trip_id):
    print("Hello, updating your trip...")

    new_data = {
        "destination": "Sweden",
        "start_date": "2026-10-11",
        "end_date": "2026-10-18",
        "budget": 600,
        "booked": True
    }

    try:
        response = requests.put(f"{URL}/trips/{trip_id}", json = new_data)
        print(response.status_code)


        if response.status_code == 200:
            print("Trip updated successfully!")
            print(response.json())
        else:
            print("There was an error updating this trip.")

    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    create_trip()
    get_all_trips()
    update_trip(1)