import numpy as np
import matplotlib.pyplot as plt

#Importing the data
tag="rbs2"
Ny=100
filename="../quant_"+tag+"_ny="+str(Ny)+".out"

data=[]
with open(filename, 'r') as infile:
    for line in infile:
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        data.append(line.split())

data = np.asarray(data, dtype=float)

om=data[:,0]
Nx=data[:,1]
c=data[:,3]
Mint=data[:,4]
Masy=data[:,5]
Q=data[:,6]
Jint=data[:,7]
Jasy=data[:,8]
gtt=data[:,9]

#Exporting the differences
out=open("delta_quant_"+tag+"_ny="+str(Ny)+".out",'w')
for i in range(len(Nx)-1):
	deltaMint=(Mint[i+1]-Mint[i])
	deltaMasy=(Masy[i+1]-Masy[i])
	deltaQ=(Q[i+1]-Q[i])
	deltaJint=(Jint[i+1]-Jint[i])
	deltaJasy=(Jasy[i+1]-Jasy[i])
	deltagtt=(gtt[i+1]-gtt[i])
	out.write("%.2f\t%d\t%d\t%.6f\t%.15e\t%.15e\t%.15e\t%.15e\t%.15e\t%.15e\n"%(om[i+1],Nx[i+1],Ny,c[i+1],deltaMint,deltaMasy,deltaQ,deltaJint,deltaJasy,deltagtt))
