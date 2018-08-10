# 320h: https://www.reddit.com/r/dailyprogrammer/comments/6j7k3x/20170624_challenge_320_hard_path_to_philosophy/

import re
import requests
from bs4 import BeautifulSoup


def next_article(visited, path, base, article):
    soup = BeautifulSoup(requests.get(base + article).text, "html.parser")
    path.append(soup.find(id="firstHeading").text)
    
    for p in soup.find(id="mw-content-text").find_all("p"):
        for a in p.find_all("a", href=True):
            if re.match("^\/wiki\/[A-Za-z_]+$", a["href"]) and \
               a["href"] not in visited:
                visited.add(a["href"])
                return a["href"]


article = "/wiki/Molecule"
article = "/wiki/Telephone"
destination = "/wiki/Philosophy"
base = "https://en.wikipedia.org/"
visited = set()
path = []

while article != destination:
    article = next_article(visited, path, base, article)
    
    if not article:
        print("search failed")
        break
    
    print("step {}: {}".format(len(path), article))
