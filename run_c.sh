#!/bin/bash

SOURCEFILE=mpi_spin_bs.edp
LOGFILE=log.txt

m=0
om=0.99
odd=1
c1=12.62512004
c2=12.64438636

nx=130
ny=50
n=15
inc=1

if (( $inc != -1 ))
then
	c=$c1
else
	c=$c2
fi

stp=$(bc -l <<<"scale=9;($c2-$c1)/($n-1)")

#mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -load 1 -save 1 -quant 1 -2Dplot 0 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny

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
	mpirun -np 4 FreeFem++-mpi -ng $SOURCEFILE -load 1 -save 1 -quant 1 -2Dplot 0 -cload $c0 -c $c -m $m -om $om -odd $odd -nx $nx -ny $ny | tee $LOGFILE
	
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
