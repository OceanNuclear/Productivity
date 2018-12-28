#!/home/ocean/anaconda3/bin/python3
from numpy import cos, arccos, sin, arctan, tan, pi, sqrt; from numpy import array as ary; import numpy as np; tau = 2*pi
from matplotlib import pyplot as plt
e = np.e
logspaced = np.logspace(0,6,num=7,base=e)#using a multiplication factor of e,
def startweek(num):
	return np.round(num*logspaced).astype(int)
Reps = startweek(1.8)
print(Reps)
def generateWks(name,number):
	assert len(name)<=4
	weeks = ["| "+name+"{0:2d}".format(n) for n in range(1,number+1)]
	weeks = "".join(weeks)
	return weeks
Aut = generateWks("Aut ", 11)
Chr = generateWks("Chr-", 4)
Spr = generateWks("Spr ", 11)
Eas = generateWks("Eas-", 4)
#print(Aut+Chr+Spr)
TermTime = Aut+Chr+Spr+Eas
f = open("RepetitionSchedule.txt","w")#write a simple text file that turns 
f.write("Actual  ")
f.write(TermTime+"\n")
f.write((8+len(TermTime))*"_"+"\n")
for n in range(len(Reps[:5])):
	f.write("Rep "+"{0:2d}".format(n)+"  ")
	f.write(Reps[n]*"|       ")
	f.write(TermTime+"\n")
f.close()