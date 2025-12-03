#!/bin/bash

SOURCEFILE=mpi_spin_bs.edp
LOGFILE=log.txt

bc=0
m=1
om=0.995
odd=0
c1=3.19062042
c2=7.0

nx=137
ny=54
n=20
inc=1

if (( $inc != -1 ))
then
	c=$c1
else
	c=$c2
fi

stp=$(bc -l <<<"scale=9;($c2-$c1)/($n-1)")

mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -load 1 -save 1 -quant 1 -2Dplot 0 -bc $bc -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny

for ((i=1;i<$n;i++))
do
	c0=$c
	if (( $inc != -1 ))
	then
		c=$(bc -l <<<"scale=9;$c+$stp")
	else
		c=$(bc -l <<<"scale=9;$c-$stp")
	fi
	
	echo "c = $c"
	mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -load 1 -save 1 -quant 1 -2Dplot 0 -bc $bc -cload $c0 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny | tee $LOGFILE
	
	CHECK_CONV=$(cat $LOGFILE | grep "Convergence=1")
	
	if [ -z "$CHECK_CONV" ]
	then
		echo "NOT CONVERGED, DIMINUTION OF THE STEP"
		c=$c0
		stp=$(bc -l <<<"scale=9;$stp*0.5")
	else
		stp=$(bc -l <<<"scale=9;$stp*1.01")
		#stp=$(bc -l <<<"scale=9;$stp*1.0")
	fi
	
done
