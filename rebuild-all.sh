#!/bin/bash

DATA_DIR="run"

FILE_LIST=($(find $DATA_DIR -maxdepth 1 -name \*.msh \
	-type f -printf '%f \n' | sort -t = -k 1 -n ))
	
ODD=0
	
for FILE in ${FILE_LIST[*]}
    do 
    echo "Treating: $FILE"
    bash convert-single.sh $DATA_DIR $FILE $ODD
    
#    break    

done

echo "End"
