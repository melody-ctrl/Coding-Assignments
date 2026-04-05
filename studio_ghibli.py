# Get movies from API
import requests # importing required library to access APIs
import pprint # makes json prettier to read
import random # can select random elements 
import pyfiglet # text styling module that prints text in ASCII art. Install using pip install

# API parameters
URL = "https://ghibliapi.vercel.app/films"
headers = {"User-Agent": "Mozilla/5.0", "Accept": "application/json"} # extra info sent to server about my web browser and that we need JSON
response = requests.get(URL, headers=headers)

print(response.status_code)  # seeing if our GET request worked

movies = response.json() # converts text response into a dictionary I can use directly in python.

pprint.pprint(movies) # this is a list of dictionaries

print("-----------------")
print("EXPLORING THE DATA...") # just playing around
print("-----------------")


# create list of movie titles 
movie_list = []
for movie in movies: 
    movie_list.append(movie["title"])

list_length = len(movie_list)
print(f"The total number of movies in this list is {list_length}")

print(movie_list[:12])

# what if we don't know the index of the movie we want? Use list comprehension (learnt in week3 day3)
movies_2013 = ([movie["title"] for movie in movies if movie["release_date"] == "2013"])
print(f"The movies released in 2013 are: {movies_2013}")

print("-----------------")
print("TAGGING THE MOVIES...")
print("-----------------")

title = pyfiglet.figlet_format("Studio Ghibli Movie Picker")
print(title)

# Tag the movies with keywords based on descriptions 
ghibli_tags = {
    "Castle in the Sky": ["adventure"],
    "Grave of the Fireflies": ["historical"],
    "My Neighbour Totoro": ["mystical"],
    "Kiki's Delivery Service": ["family"],
    "Only Yesterday": ["historical"],
    "Porco Rosso": ["historical"],
    "Pom Poko": ["mystical"],
    "Whisper of the Heart": ["romance"],
    "Princess Mononoke": ["mystical"],
    "My Neighbors the Yamadas": ["family"],
    "Spirited Away": ["mystical"],
    "The Cat Returns": ["adventure"]
}
      
# Ask User questions about their day
print("Welcome! This program will recommend a Studio Ghibli movie to watch tonight based on your day today.")
print("Tell me how your day went by choosing one of the following options: ")

print("- Stressful") # mystical
print("- Nostalgic") # historical
print("- Emotional") # romance
print("- Boring") # adventure
print("- Sad") # family


# Exception handling 
class InvalidOption(Exception):
    pass

valid_options = ["stressful", "nostalgic", "emotional", "boring", "sad"]

try: 
    choice = input("Please enter your answer: ").lower()
    if choice not in valid_options:
        raise InvalidOption("Error: Invalid Option Entered")
except InvalidOption as e: 
    print(f"{e} : That is not a valid option. Please try again.")

if choice == "stressful":
    selected_tag = "mystical"
elif choice == "nostalgic":
    selected_tag = "historical"
elif choice == "emotional":
    selected_tag = "romance"
elif choice == "boring":
    selected_tag = "adventure"
elif choice == "sad":
    selected_tag = "family"
# else:
#     print("Invalid choice, defaulting to something magical")
#     selected_tag = "mystical"


# list comprehension
# making list of movies matching the tags the user chose.
matches = [title for title in ghibli_tags if selected_tag in ghibli_tags[title]]

# Using import random module. For when there are multiple matches, choose a random one.
# For a single match, just return it, and for anything else, return a random choice from list of movies.
def choose_movie(matches, ghibli_tags):
    if len(matches) > 1:
        return random.choice(matches)
    elif len(matches) == 1:
        return matches[0]
    else:
        return random.choice(ghibli_tags.keys())

chosen_movie = choose_movie(matches, ghibli_tags)

# A function to provide custom messages to user based on their answer.
def custom_message(selected_tag):
    if selected_tag == "mystical":
        return "You definitely need to escape reality tonight. You should watch "
    elif selected_tag == "historical":
        return "It seems like you could do with a blast from the past. You should watch "
    elif selected_tag == "romance":
        return "You need something heartfelt and romantic. You should watch "
    elif selected_tag == "adventure":
        return "You probably need to go on an exciting adventure. You should watch "
    elif selected_tag == "family":
        return "Tonight, you need comfort and feel-good moments. You should watch "

final_message = custom_message(selected_tag)
print(final_message + chosen_movie)





