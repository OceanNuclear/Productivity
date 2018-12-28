#!/home/ocean/anaconda3/bin/python3
#Impose --quiet and --rest-time
#Allow it to be ran from terminal using "S 30" #to take a 30 minutes break before starting
#Can be done using https://stackoverflow.com/questions/3577163/how-to-input-variable-into-a-python-script-while-opening-from-cmd-prompt
import datetime, sys
global TASKNUM
VERBOSE = False
TASK_LIM=5
TASKNUM=0
current_time = (datetime.datetime.now().hour,datetime.datetime.now().minute)
if __name__=="__main__":
	print(sys.argv[1:])