#!/home/ocean/miniconda3/bin/python3
#1. Allow brackets in the last line of output to be read if there are no time statements
import datetime, sys
global TASKNUM
TASK_LIM=5
TASKNUM=0
VERBOSE = True
current_time = (datetime.datetime.now().hour,datetime.datetime.now().minute)
args = sys.argv[1:]

def incrementTime(startTime, dt):#first part is the start time, second is dt
	(hour, minutes) = startTime
	(hour2,minutes2)= dt
	total_mins = 60*(hour+hour2)+minutes+minutes2

	minutes = total_mins%60
	hour = int(total_mins/60)%24
	#assert type(minutes)==int
	return (hour, minutes)
def grep(key,List):
	TF = [ (key in a) for a in List ]
	return bool(sum(TF))

if len(args)>0:#would've put it at the start of the code if I could :(
	#Quiet flag
	if grep("-h",args) or grep("--help",args):
		print("Scheduler.py intruction:")
		print("Allowed flags:")
		print("-r resttime")
		print("-n numberoftask")
		print("-l numberoftask")
		print("-q (quiet)")
		print()
		print("Format:")
		print("All lines containing 'am'/'pm' will be treated as a new start time, and will reset the clock.")
		print("All lines beginning with '[]' will be treated as a task.")
		print("All other lines will be ignored.")
		print()
		print("Written by Ocean Wong")
		sys.exit()
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
		current_time = incrementTime(current_time,(0,rest_mins))
	if grep ("-n", args) or grep("-l", args):
		ind = [ n for n in range(len(args))  if ("-n" in args[n]) or ("-l" in args[n]) or ("--task-lim" in args[n]) ]
		assert len(ind)==1, "you can use '-n', '--num', '-l', '--lim', '--limit', '--task-lim' or '--task-limit' to declare the TASK_LIM variable"
		args = [ a.replace("--num","").replace("-n","").replace("--task-limit","").replace("--task-lim","").replace("--limit","").replace("--lim","").replace("-l","") for a in args]
		args = [a for a in args if a!=""]
		TASK_LIM= int(args[ind[0]])

def indentLvL(line):
	#if not line.startswith(" "): return 0
	for n in range(16,-1,-1):
		if line.startswith(" "*n):
			return n
def toAPM(time):
	(hour, minutes) = time
	if 12<=hour<24:
		PM=True
	elif 0<=hour<12:
		PM=False
	else:
		print("I suck at programming. 'Hour' not in bounds")
		assert type(minutes)==int, ValueError("you suck even more because there's a wrong type")
	hour = ((hour-1)%12)+1
	end_time= str(hour)+":"+'{:02}'.format(minutes)
	if PM:
		end_time+="pm"
	elif not PM:
		end_time+="am"
	return end_time	#which is a str
def ImprovedPrompt4time(startTime):
	string = input("    ->Estimated time required for this task?\n")
	string = "    "+string
	time,line= duration(startTime,string)
	return line+"\n",time
def istimestatement(line,bracketed=False):	#is a statement that declares the duration of the preceeding task.
	line=line.replace("(","").replace(")","")
	assert len(line.split("\n"))==2	#check that it only contains only 1 sentence+1 newline character
	#print([print(n+"") for n in line[:5]])
	#if len(line)>4: pass
	if not line.startswith("    "):#must four spaces indent
		return False
	#print(line[4].isdigit())#first letter must be a digit
	if line[5]==".":
		if not bracketed:
			return False
	if line[4].isdigit() and (('am' in line) or ("pm" in line) or (":" in line) or ("in" in line) or ("our" in line) or ('hr' in line)):#account for 24 hour expression, 12 hours expression, and duration expression
		return True#first non-space character is a digit.
	else:
		return False
def string2time(string):#
	hour_mins=string.split(":")#split the string at the colon.
	hour = int(hour_mins[0])#choose the first number as the hour
	minutes = 0	
	if len(hour_mins)==2:
		minutes=int(hour_mins[1])
	elif (len(hour_mins)>=1):
		print("Something's wrong, 2+ ':'s found in the time declaration statement")
	return (hour, minutes)
def breakatalpha(line):
	alpha = 'HRShoursMINminute'
	string = "".join([" " if l in alpha else l for l in line])
	assert sum([c.isalpha() for c in string])==0, "There are non-minute/hour string in this duration line" #make sure that there are no OTHER alphabets
	array = string.split()
	return array
def duration(time,line):#assume the line already has the relevant time info in it
	#i.e. the line has passed through the appropriate filters.
	line=line.replace("(","").replace(")","")
	if  (line.count("am")+line.count("pm"))>0:
	#if it has the end_time already:
		#remove the that end_time
		if line[5]==":":
			line = "    "+line[11:]
		else:
			assert line[6]==":"
			line = "    "+line[12:]
	#At this point we should be left with a line with NO start/end_time statement
	assert line.count("am")+line.count("pm")==0,"Multiple am/pm statements in this line?"
	
	#<extract Δt>
	#<True statements>
	_hour = ("hr"in line) or ("our" in line) or ("Hr" in line)
	_mins = ("in" in line)
	_colon= (":" in line)
	if (_hour or _mins): assert (not _colon),"hybrid statement between 'am'/'pm' and 'hour'/'mins'!"
	if (_colon): assert not (_hour or _mins),"hybrid statement between 'am'/'pm' and 'hour'/'mins'!"
	assert sum([_hour,_mins,_colon])!=0, "there are no ':' or 'a/pm'!"
	#</True statements>
	times = breakatalpha(line)#remove all spaces, then them up at alphabets.
	hours, minutes = 0,0#using plural for int.
	#convert the hour into minutes
	if  _hour:#if there is a declaraction of hour
		HR = times[0].split(".")#at this point, it's still one/two string(s)
		assert len(HR)<=2,"more than one dot in the expression for hour"
		hours = int(HR[0])
		if len(HR)>1:
			minutes=int( float("."+HR[1])*60 )#includes the dot when floating.
			#print("'min'syntax block inside the _hour block extracted minutes as", minutes)
		#print("'_hour' syntax if blocks extracted hours as",hours)
	if  _mins:#if there is a declaration of minutes
		minutes= int(times[-1])#directly convert string into a thing
		#print("'_mins' syntax if blocks extracted minutes as",minutes)
	Δt = (hours,minutes)
	if (_colon and (not _hour) and (not _mins)):
		#only I:II or II:II
		#if there is a colon, there shouldn't be any word left on the line.
		assert len(times)==1, "There is a colon but there are multiple numbers separated by letters and spaces?"
		#only 1 element should remain in 'times', and it must have a ":" in the middle
		Δt = string2time(times[0])
	#</extract Δt>
	#print("input to incrementTime is",time,Δt)
	time=incrementTime(time,Δt)#each of these two input variables are of shape (hour,minutes)
	line = "    "+toAPM(time)+" "+line[4:]
	return (time,line)
def findLastBracketed(blockOfText):
	lbrack = [n for n in range(len(blockOfText)) if blockOfText[n]=="("]
	rbrack = [n for n in range(len(blockOfText)) if blockOfText[n]==")"]
	if len (rbrack)!=0 and len(lbrack)!=0:
		end = rbrack[-1]
		start=lbrack[-1]
		return blockOfText[start+1:end]
	return "  "
def wrap_up(time, blockOfText):
	global TASKNUM
	data = [ t+'\n' for t in blockOfText.split("\n") ]
	#no more new line characters
	#declare some local variables
	output = "";TIME_DECLARED=False
	if data[0].startswith("[]"):#check if this block of text describes a task or not.
		TASK = True
		TASKNUM+=1
	else:
		TASK = False
	
	for line in data:	#loop through every line to find a time-statement
		if TASK and istimestatement(line):#is a timestatment for the task
			##if TASKNUM<=TASK_LIM:#update the time only if TASK doesn't exceed limit
			(time,line) = duration(time,line)	#update the time.
			TIME_DECLARED=True
		#treat lines that are not time-statements as normal
		output+=line#convert that line line statement and leave.
	#Finished "rummaging" through all of the lines.
	output=output[:-1]#for reason beyond me, I have to remove the last newline character for it to work.

	if not TASK:#exit function if it's not even a task
		return(time, output)
	#only TASKs remains
	if VERBOSE: print (output[:-1])#print the task itself before going any futher.
	#print(...[-1])avoids printing an extra line!
	
	if TIME_DECLARED:return(time,output)#exit the function if we don't care about this task

	#Only tasks that still doesn't have TIME_DECLARED gets passed down here.
	#Try to read the last bracket for a time
	lastBracketedText = "    "+findLastBracketed(output)+"\n" #Turn that into a proper line
	if istimestatement(lastBracketedText,bracketed=True): #prepended four spaces, allows for reusing the old function (duration()) in the first case below
		time, line = duration(time,lastBracketedText)
	else:	#if a readable "(duration)" is still not found within the text block
		if (TASKNUM<=TASK_LIM):
			#line, time,dummy_dt = prompt4time(time)
			line, time = ImprovedPrompt4time(time)
		else:
			line=""
	if VERBOSE: 
		if line!="" : print(line[:-1])
	output+=line
	return (time, output)
def conv2startTime(line):
	thres =11 #Threshold number of alphabets to cause the line ot be recognized as not a time statement
	#if it is not a start time statement just return None
	line = line[:-1]#remove the newline character
	if line=="current_time" or line=="now": #special feature to allow readjustment of start time
		TIME_DECLARED=True
		time=(datetime.datetime.now().hour,datetime.datetime.now().minute)
		return time
	NotATimeStatement = (not indentLvL(line)==0) or line.startswith("[") or sum([l.isalpha() for l in line ])>thres or line.endswith(":") or line.endswith(": ")
	if NotATimeStatement:
		return None
	if len(line)<1:
		return None
	#Hopefully only proper time-statements are left;
	TIME_DECLARED=False#This will help weed out the remaining ones
	APM= ( ('am' in line) or ("pm" in line) )
	#(I)I:II(xm)
	if ":" in line[1:3]:
		TIME_DECLARED=True
		if line[1]==":":
			hour = line[0:1]
			minute = line[2:4]
		if line[2]==":":
			hour = line[0:2]
			minute = line[3:5]
		hour=int(hour)
		minute=int(minute)
	#I(I)xm declaration
	if not ":" in line:
		if APM:
			TIME_DECLARED=True
			hour = int( line.replace("pm","").replace("am","").split()[0] )
			minute = 0
	if APM:	#know that when we write 12 o'clock we mean 0 o'clock.
		assert 1<=hour<=12, "HOUR not in range!"
		if hour==12: hour=0
	if ("pm" in line):#turn it back up
		hour+=12
	if TIME_DECLARED==True:#if any of the if conditions above were activated:
		time=(hour,minute)
		return time
if __name__=="__main__":
	f = open("/home/ocean/Desktop/Schedule.txt","r")#hard coded file location
	text=f.readlines()
	f.close()
	o = open("/home/ocean/Desktop/Schedule.txt","w")
	buffer=""
	for line in text:
		tried_converting2Time=conv2startTime(line)
		#If it's a start time,
		if (tried_converting2Time!=None):
			(current_time,buffer)=wrap_up(current_time,buffer)
			o.write(buffer);buffer=""#dump and clear buffer.
			current_time = tried_converting2Time
			o.write(line)	#write the start time back to the output file (without using buffer)
		#check if it is a new task/1st level comment
		elif "[]" in line or indentLvL(line)==0:
			#end the task at when the next instance is unindented/
			(current_time, buffer)=wrap_up(current_time,buffer)
			#then wrap up the previously saved texts.
			o.write(buffer);buffer=""	#then make a new instance
			buffer+=line
		#All other cases, where it isn't asking to start a new task/time statement
		else:
			buffer+=line#simply append to buffer
	#at end of file, dump buffer's data
	o.write(buffer)
	o.close()
	
	#Discarded code for def duration
	'''
	if False:
		#removed feature to simply add minutes on the existing schedule.
		#find the time, and add it in.
		if line.count("am")==1:
			times = [word.replace("am","") for word in line.split() if not word.isalpha()]#remonvig the word "am"
			(hour,minutes)=string2time(times[0])
		elif line.count("pm")==1:
			times = [word.replace("pm","") for word in line.split() if not word.isalpha()]
			(hour,minutes)=string2time(times[0])
			hour+=12
		time = (hour,minutes)
		Δt	= (0,0)
	#assert sum([word.isalpha() for word in words])==0#no english characters within that line.
	'''
	'''
	if len(words)==1:
		#it must be a staement of how long is it to start
		word = words[0]
		if word.endswith("pm"):
			word=word.replace("pm","")
		elif word.endswith("am"):
			word=word.replace("pm","")
		if word.find(":")==1:
			ind = word.index(":")
			word.00
		else: raise ValueError
		toMins(hour, mins)
		Δt = (word)
		return
	elif len(words)==2:
		#it must be a completed start and end time calculation.
	'''
