#!/bin/bash

datafile="quant.out"   # your data file
folder="run"            # your folder with .fem/.msh files

# Read first column values into an array
mapfile -t om_values < <(awk '{print $1}' "$datafile")

for f in "$folder"/*om=*; do
    # Extract the om value from the filename
    om=$(echo "$f" | grep -oP 'om=\K[^_.]+(\.[0-9]+)?')
    
    for val in "${om_values[@]}"; do
        if [ "$om" == "$val" ]; then
            echo "Deleting: $f"
            rm "$f"
            break
        fi
    done
done
