#!/bin/bash
if [ $# != 3 ]
then 
    echo "ERROR"
    echo "$# is a wrong number of parameters (must be 3)"
    exit 1
fi; ORIG_IFS=$IFS
#echo "**************************************"
#echo "Job submitted for the parameter set : "
#echo "**************************************"
#echo " DATA_DIR=${1}"
#echo " FILE=${2}"
DATA_DIR=${1}; FILE=${2}; ODD=${3};


#FILE_NAME="${FILE%.*}"
FILE_NAME="${FILE%.*}"
FILE_EXT="${FILE##*.}"

echo $FILE_NAME $FILE_EXT
################################################################
### HASH PARAMETERS FROM FILENAMES
################################################################
IFS='_';  FileArray=( $FILE_NAME );  IFS=$ORIG_IFS   

#echo ${FileArray[0]}
#echo ${FileArray[1]}
#echo ${FileArray[2]}
#echo ${FileArray[3]}
NAME_PREFIX=${FileArray[0]}

VAR_C=${FileArray[1]}; IFS='='; C_ARRAY=(${VAR_C}); IFS=$ORIG_IFS
C=${C_ARRAY[${#VarArray[@]}-1]}

VAR_M=${FileArray[2]}; IFS='='; M_ARRAY=(${VAR_M}); IFS=$ORIG_IFS
M=${M_ARRAY[${#VarArray[@]}-1]}

VAR_OM=${FileArray[3]}; IFS='='; OM_ARRAY=(${VAR_OM}); IFS=$ORIG_IFS
OM=${OM_ARRAY[${#VarArray[@]}-1]}

RECONSTRUCTED_NAME=${NAME_PREFIX}_c=${C}_m=${M}_om=${OM}_odd=F.$FILE_EXT

if [ ! -f $DATA_DIR/$RECONSTRUCTED_NAME ]; then echo "File $RECONSTRUCTED_NAME do not exist"; exit 1 ; fi


##########################################
#echo " - doing something for alpha = $AL"

SOURCEFILE=mpi_spin_bs.edp

mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -matplot 1 -acu 15 -bc 0 -c $C -m $M -om $OM -odd $ODD -nx 137 -ny 54


##########################################
