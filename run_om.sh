#!/bin/bash

SOURCEFILE=mpi_spin_bs.edp
LOGFILE=log.txt

bc=1
c=1.0
m=0.0
om=0.842379101537
odd=1
nx=274
ny=54

del=0.0001
n=100

#mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -acu 15 -bc $bc -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny

for ((i=0;i<$n;i++))
do
	om0=$om
	#om=$(bc -l <<<"scale=12;$om-$del")
	om=$(bc -l <<<"scale=12;$om+$del")
	
	echo "Omega = $om"
	
	mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -save 1 -load 1 -quant 1 -2Dplot 0 -matplot 1 -acu 15 -bc $bc -c $c -m $m -omload $om0 -om $om -odd $odd -nx $nx -ny $ny | tee $LOGFILE
	
	CHECK_CONV=$(cat $LOGFILE | grep "Convergence=1")
	
	if [ -z "$CHECK_CONV" ]
	then
		echo "NOT CONVERGED"
		om=$om0
		del=$(bc -l <<<"scale=12;$del*0.5")
	else
		del=$(bc -l <<<"scale=12;$del*1.0")
	fi
	
done
