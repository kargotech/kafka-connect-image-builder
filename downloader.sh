#!/bin/bash

mkdir plugins/
cd plugins/

while read plugin; do
  curl "$plugin" | tar xvz
done < ../plugins.txt
