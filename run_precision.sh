#!/bin/bash

SOURCEFILE=mpi_spin_bs.edp

c=12.635047045
m=0
om=0.99
odd=1
nx=647
ny=50

n=10

mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny

for ((i=0;i<$n;i++))
do
	ny=$(bc -l <<<"$ny+5")
	
	echo "Nb. points = $ny"
	
	mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny
	
done
