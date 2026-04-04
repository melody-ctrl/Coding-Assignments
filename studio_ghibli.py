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

print("-----------------")
print("EXPLORING THE DATA...")
print("-----------------")

# create list of movie titles 
movie_list = []
for movie in movies: 
    movie_list.append(movie["title"])

print(len(movie_list))

print(movie_list[:12])

ghibli_tags = {
    "Castle in the Sky": ["Adventure"],
    "Grave of the Fireflies": ["Historical"],
    "My Neighbour Totoro": ["Mystical"],
    "Kiki's Delivery Service": ["Family"],
    "Only Yesterday": ["Historical"],
    "Porco Rosso": ["Historical"],
    "Pom Poko": ["Mystical"],
    "Whisper of the Heart": ["Romance"],
    "Princess Monoke": ["Mystical"],
    "My Neighbors the Yamadas": ["Family"],
    "Spirited Away": ["Mystical"],
    "The Cat Returns": ["Adventure"]
}
      
# what if we don't know the index of the movie we want? Use list comprehension (learnt in week3 day3)
movies_2013 = ([movie["title"] for movie in movies if movie["release_date"] == "2013"])
print(movies_2013)

# Tag the movies with keywords based on descriptions 

# Ask User questions about their day
print("Hi. This program will recommend a Studio Ghibli movie to watch this evening based on your day today. Please answer the following questions.")
"https://ghibliapi.vercel.app/films"