#!/bin/bash

SOURCEFILE=mpi_spin_bs.edp

c=1.619436525
m=0
om=0.9
odd=1
nx=19
ny=50

n=281

mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -acu 15 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny

for ((i=0;i<$n;i++))
do
	nx=$(bc -l <<<"$nx+1")
	#ny=$(bc -l <<<"$ny+1")
	
	echo "Nb. points = $ny"
	
	mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -acu 15 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny
	
done
