import random

genres = ["pop", "rock", "classical", "jazz", "metal", "country", "hip-hop"]

print "volume,density,genre"

for i in range(40):
    volume = random.randint(10, 45)
    density = random.randint(10, 45)
    genre = random.choice(genres)
    print "{},{},{}".format(volume, density, genre)

