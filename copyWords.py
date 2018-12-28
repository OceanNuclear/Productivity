#!/home/ocean/anaconda3/bin/python3
import random as rn
from os import listdir, chdir
import clipboard
#copies contents of the entire *.txt file from Documents/Work/17.DailyThought/ and Documents/Thoughts

def getText(filename):	#for docx files only
	from docx import Document
	doc = Document(filename)
	fullText = []
	for para in doc.paragraphs:
		fullText.append(para.text)
	return '\n'.join(fullText)

def Thoughts():
	chdir("/home/ocean/Documents/Thoughts")
	files = listdir()
	files.remove("Link to 17.DailyThought")
	chosenFile = rn.choice(files)
	if chosenFile[-4:]=="docx":
		text = getText(chosenFile)
	else:
		f = open(chosenFile, "r")
		text = f.readlines()
		text = '\n'.join(text)
		f.close()
	return chosenFile+text

def DailyThought():
	chdir("/home/ocean/Documents/Work/17.DailyThought")
	files = listdir()
	files.remove("Link to Thoughts")
	chosenFile = rn.choice(files)
	f = open(chosenFile, "r")
	text = f.readlines()
	text = '\n'.join(text)
	f.close()
	return chosenFile+text

if __name__=="__main__":
	#0.25 chance of picking /home/daily thoughts,
	#0.75 chance of picking /Documents/Thoughts
	decision = rn.random()
	if decision<0.75: text = Thoughts()
	else: text = DailyThought()
	clipboard.copy(text)