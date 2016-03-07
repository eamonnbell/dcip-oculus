import random

genres = ["pop", "rock", "classical", "jazz", "metal", "country", "hip-hop"]

print "volume,genre"
for i in range(20):
    volume = random.randint(25, 100)
    genre = random.choice(genres)
    print "{},{}".format(volume, genre)

