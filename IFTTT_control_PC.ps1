#Change the SearchDirectory with your OneDrive/DropBox directory
$SearchDirectory = "C:\Users\xxx\OneDrive\Amazon Alexa\"

#Scan Frenquency in Seconds
$SleepTime = 1

#Removes the file from the directory, in case the file was not deleted. Sets the error action in case the file is not present.
Remove-Item -Path "$SearchDirectory\shutdown" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$SearchDirectory\hibernate" -Force -ErrorAction SilentlyContinue
#More use cases just copy paste above and change the filename here

Do {
	if(Test-Path -Path "$SearchDirectory\shutdown")
	{
		#Removes the shutdown file to prevent an imediate shutdown when the computer starts back up
		Remove-Item -Path "$SearchDirectory\shutdown"
		#Shuts the computer down forcefully but gracefully
		cmd.exe /c "%windir%\System32\shutdown.exe -s -t 0"
		$FileCheck = $True
	}
	elseif(Test-Path -Path "$SearchDirectory\hibernate")
	{
		#Removes the hibernate file to prevent an imediate shutdown when the computer starts back up
		Remove-Item -Path "$SearchDirectory\hibernate"
		#hibernate the computer
		cmd.exe /c "%windir%\System32\shutdown.exe /h"
		$FileCheck = $True	
	} 
	#More use cases just add below this line with "elseif statement"
	else
	{
		$FileCheck = $False
	}
	Start-Sleep -Seconds $SleepTime
}
Until ($FileCheck -eq $True)
