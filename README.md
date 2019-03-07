#Objective
Voice control to shutdown / hibernate PC with combinition of Amazon Alexa, IFTTT, PowerShell script, Task Scheduler, and OneDrive/DropBox



##Salutation
This script is an modified version of [MaxAnderson95's Shutdown-PC-via-IFTTT](https://github.com/MaxAnderson95/Shutdown-PC-via-IFTTT) script by adding in If-Elseif-Else statement so that more use cases can be add in easily.

Currently I am using it to Shutdown and Hibernate my PC.

## Prerequisite
* IFTTT should be already connected Amazon Alexa
* IFTTT should be already connected to OneDrive/DropBox
* OneDrive/DropBox should be already logged in and running (synchronizing)

##Steps
### IFTTT Setup
1. Login to IFTTT, Click on New Applet

2. Click on "✚ this"

3. Search and Choose "Amazon Alexa"
<img src="https://i.imgur.com/qvynHRo.png" width="480">

4. Choose "Say a specific phrase"
<img src="https://i.imgur.com/jMsEVjV.png" width="480">

5. What Phrase: Insert your desire phrase to shutdown, Click "Create Trigger"
<img src="https://i.imgur.com/dQZtxYh.png" width="480">

6. Click on "✚ that"

7. Search and Choose "OneDrive" or "DropBox"
<img src="https://i.imgur.com/u1lk3nF.png" width="480">

8. Choose "Create text file"
<img src="https://i.imgur.com/Wwc5cuE.png" width="480">

9. Complete action fields
* Filename: "shutdown" (If file name changed here, you should change PowerShell script's file name too)
* Folder Path: Desire path (Will be use in "Computer Setup" Step 2 below.)
* Content: anything as long as not blank
* Click Create action
<img src="https://i.imgur.com/xTxpdvb.png" width="480">

10. Click Finish

11. Repeat step 1 to 10 for Hibernating the PC, only change below information 
* Step 5, Change to your desire phrase to hibernate 
* Step 9, Filename: "hibernate" (If file name changed here, you should change PowerShell script's file name too)

### Computer Setup
1. Download and put the PowerShell Script into desire location

2. Change line 2 to folder that you set in IFTTT (Should be within OneDrive/DropBox directory)

3. Change line 3 to desire sleeptime between file checks

4. Open "Task Scheduler"

5. On right panel, Click Create Task

6. In "General" Tab, Change/Insert
* Name: "desire name"
* Select Run whether user is logged on or not
* Tick: Run with highest privileges
* Tick: Hidden
* Configure for: Windows 10
<img src="https://i.imgur.com/C0UqQ9U.png" >

7. In "Trigger" Tab, Click "New", Choose/Insert
* Begin the task:  At startup
* Tick: Enabled
<img src="https://i.imgur.com/4UgzJZN.png" >

8. In "Action" Tab, Click "New", Change/Insert
* Action: Start a program
* Program/script: powershell.exe -file "Path_to_downloaded_Powershell_script"
<img src="https://i.imgur.com/QwvV3mA.png" >

9. Click OK 

### How it work
1. Speak the magic phrase
2. Amazon Alexa will create a file in OneDrive/DropBox
3. PC will 
1. When PC startup, Task Scheduller will run the PowerShell script

2. The PowerShell script will scan the folder you inserted in "Computer Setup" Step 2 based on internval set in "Computer Setup" Step 3

3. When you speak the magic phrase to Alexa

4. Amazon Alexa will create a file in OneDrive/DropBox

5. Upon interval time, the PowerShell Script will detect the file

6. The PowerShell script will read the file name and match with IF-Elseif-Else statment 

7. Lastly, command will be executed based on file name detected

### Add in use cases (Optional)
1. To add in more use cases, you will have to create respective IFTTT applet for it, just change the phrase and filename.

2. In the script file, Add below
* After line 7,
```
Remove-Item -Path "$SearchDirectory\your_new_filename" -Force -ErrorAction SilentlyContinue
```

* After line 25,
```
	elseif(Test-Path -Path "$SearchDirectory\your_new_filename")
		{
			Remove-Item -Path "$SearchDirectory\your_new_filename"
			YOUR_NEW_COMMAND
			$FileCheck = $True	
		}
```

3. Restart your computer or go to Task Scheduler, End and Run the task.

## Author
Kavier Koo 
Any queries, please contact me [here](http://kavierkoo.com/#contact)

### License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT)

## Acknowledment
* [MaxAnderson95's Shutdown-PC-via-IFTTT](https://github.com/MaxAnderson95/Shutdown-PC-via-IFTTT) 



