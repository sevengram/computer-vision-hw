#!/usr/bin/env bash

python3 features.py tiny
python3 knn.py
python3 lda.py --task=tiny