#!/bin/bash

# získa všetky parametre a spojí ich s "+"
query=$(echo "$*" | tr ' ' '+')

# nastavenie URL s hladanou frázou
URL="https://arxiv.org/search/?query=$query&searchtype=all&abstracts=show&order=-announced_date_first&size=50"

# stiahnutie obsahu stránky
html=$(curl -s -L "$URL")

# cistenie - odstranenie novych riadkov a zmena < na novy riadok
html_ciste=$(echo "$html" | tr -d '\n' | tr '<' '\n')

# extrakcia pomocou grep
odkazy=$(echo "$html_ciste" | grep -o 'https://arxiv.org/abs/[0-9A-Za-z.-]*')

# extrakcia pomocou sed
kody=$(echo "$odkazy" | sed 's|https://arxiv.org/abs/||')

# odstranenie rovnakých odkazov
konecne_kody=$(echo "$kody" | sort | uniq)

# vypis výsledku
echo "$konecne_kody"

