# YouTubeUploadScripts

Very simple program based on the YouTube API Example, found [here](https://developers.google.com/youtube/v3/quickstart/python) and [here.](https://developers.google.com/youtube/v3/guides/uploading_a_video) 

You need to install python 2.7 (yes, it's dead, but they didn't update it and I didn't have the time to make the changes to update it to 3.x). 
You also need the python launcher, (for py.exe), so install Python 3 and ensure to check that as well during install.

Clone the repository to a folder of your choice, then open an admin powershell prompt in that folder, and type `py -2 -m pip install -r requirements.txt`

Once those are installed, simply run, in a powershell prompt, upload_all.ps1. You can provide two parameters via the command line, -directory and -titleEnd, -directory provides the directory which it will upload the video files from,
while -titleEnd will add whatever string you add to it at the end of a video. For instance, `.\upload_all.ps1 -titleEnd "Example Video"`, will upload all videos in a directory you choose via a GUI prompt
lets say there's a file called Big Fish.mp4, it'll upload that as "Big Fish Example Video". You can also specify the directory directly from the powershell if you like, using the `-directory` parameter, so
`.\upload_all.ps1 -directory "C:\Videos\Example\" -titleEnd "Example Video"` would upload any video in `C:\Videos\Example\`, such as Big Fish.mp4, with "Example Video" appended to the title. 


