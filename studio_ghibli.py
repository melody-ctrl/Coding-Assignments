# “Which Studio Ghibli Movie Should You Watch?”

# Your program:

# Asks the user a series of questions (mood, genre, pace, etc.)
# Calls the Studio Ghibli API
# Filters movies based on answers
# Recommends the best match
# Saves results to a file

import requests 

URL = "https://ghibliapi.vercel.app/films"


headers = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"} 
response = requests.get(URL, headers=headers)

print(response.status_code)  # <-- check the response

data = response.json()

print(data)