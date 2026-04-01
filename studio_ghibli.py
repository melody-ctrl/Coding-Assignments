# Get movies from API
import requests # importing required library to access APIs
import pprint # makes json prettier to read

# API parameters
URL = "https://ghibliapi.vercel.app/films"
headers = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"} # extra info sent to server about my web browser and that we need JSON
response = requests.get(URL, headers=headers)

print(response.status_code)  # seeing if our GET request worked

movies = response.json() # converts text response into a dictionary I can use directly in python.

pprint.pprint(movies) # this is a list of dictionaries

print("-----")
print("EXPLORING THE DATA...")

print(f"The fourth movie in the list is {movies[3]["title"]}") # to access a title that we know the index. We use index as it's a list, then state the dict key we want

# what if we don't know the index of the movie we want?
# for movie in movies: 
#     if movie["release_date"] == "2013":
#         print(movie["title"])

# using list comprehension (learnt in week3 day3)
movies_2013 = ([movie["title"] for movie in movies if movie["release_date"] == "2013"])
print(movies_2013)


# Ask User questions about their day
