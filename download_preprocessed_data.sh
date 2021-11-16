#!/bin/bash

mv data data_old

mkdir data
wget https://nlp.stanford.edu/projects/myasu/QAGNN/data_preprocessed_release.zip -P data
cd data && unzip data_preprocessed_release.zip && mv data_preprocessed_release/* . && rm -rf data_preprocessed_release
