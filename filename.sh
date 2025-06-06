#!/bin/bash

# Define the input file
input_file="input.txt"

# Check if file exists
if [[ -f "$input_file" ]]; then
  echo "Reading file: $input_file"

  # Loop through each line
  while IFS= read -r line; do
    echo " aws ecr create-repository --repository-name $line --region ap-south-1 "
       aws ecr create-repository --repository-name $line --region ap-south-1
  done < "$input_file"

else
  echo "File $input_file not found!"
fi
