#!/home/ocean/anaconda3/bin/python3
#Impose --quiet and --rest-time
#Allow it to be ran from terminal using "S 30" #to take a 30 minutes break before starting
#Can be done using https://stackoverflow.com/questions/3577163/how-to-input-variable-into-a-python-script-while-opening-from-cmd-prompt
import datetime, sys
global TASKNUM
VERBOSE = True
TASK_LIM=5
TASKNUM=0
def grep(key,List):
	TF = [ (key in a) for a in List ]
	return bool(sum(TF))
current_time = (datetime.datetime.now().hour,datetime.datetime.now().minute)

if __name__=="__main__":
	args = sys.argv[1:]
	if len(args)>0:#would've put it at the start of the code if I could :(
		#Quiet flag
		if grep("-q",args) or grep("--quiet",args):
			#remove the -q flag
			args = [ a for a in args if ((a!="-q") and (a!="--quiet"))]#and (arg!="=") and (arg!="-r") and (arg!="--rest-time")
			args = [ a for a in args if a!="" ]
			VERBOSE=False

		#clean all equal signs
		args = [ a.replace("=","") for a in args ]
		args = [ a for a in args if a!="" ]#remove all of the empty string elements
		#Add-rest-time flag 
		if grep("-r",args) or grep("--rest-time",args):
			ind = [ n for n in range(len(args)) if ("-r" in args[n]) ]
			assert len(ind)==1, "Make sure that there is one -r flag"
			#remove the -r flag
			args = [ a.replace("--rest-time","").replace("-r","") for a in args ]
			args = [ a for a in args if a!="" ]#remove all of the empty string elements
			rest_mins = int(args[ind[0]])
			print(str(current_time)+" Added by "+str(rest_mins) )
		if grep ("-n", args) or grep("-l", args):
			ind = [ n for n in range(len(args))  if ("-n" in args[n]) or ("-l" in args[n]) or ("--task-lim" in args[n]) ]
			assert len(ind)==1, "you can use '-n', '--num', '-l', '--lim', '--limit', '--task-lim' or '--task-limit' to declare the TASK_LIM variable"
			args = [ a.replace("--num","").replace("-n","").replace("--task-limit","").replace("--task-lim","").replace("--limit","").replace("--lim","").replace("-l","") for a in args]
			args = [a for a in args if a!=""]
			TASK_LIM= int(args[ind[0]])
	print('TASK_LIM=',TASK_LIM,'VERBOSE=',VERBOSE)