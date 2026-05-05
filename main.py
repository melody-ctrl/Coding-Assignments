import requests 

# API parameters
URL = "http://127.0.0.1:5000"


#POST 
def create_trip():
    print("Hello, welcome back to your travel tracker. Let's track a new trip...")
        
    new_trip = {
        "destination": "Albania",
        "start_date": "2026-07-02",
        "end_date": "2026-07-08",
        "budget": 450
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
    
    except Exception as e: # for crashes, before rest of above code can even run 
        print("Request failed:", e)



