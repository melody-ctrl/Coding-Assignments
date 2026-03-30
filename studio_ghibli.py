# Get movies from API
import requests #importing required library to access APIs

URL = "https://ghibliapi.vercel.app/films"


headers = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"} # extra info sent to server about my web browser and that we need JSON
response = requests.get(URL, headers=headers)

print(response.status_code)  # check the response

data = response.json() # converts text response into a dictionary I can use directly in python.
print(data.keys())



# r = data[0]

# Ask User questions about their day