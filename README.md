# YouTubeUploadScripts

Very simple program based on the YouTube API Example, found [here](https://developers.google.com/youtube/v3/quickstart/python) and [here.](https://developers.google.com/youtube/v3/guides/uploading_a_video) 

You need to install python 2.7 (yes, it's dead, but they didn't update it and I didn't have the time to make the changes to update it to 3.x). 
You also need the python launcher, (for py.exe), so install Python 3 and ensure to check that as well during install.

Clone the repository to a folder of your choice, then open an admin powershell prompt in that folder, and type `py -2 -m pip install -r requirements.txt`

Once those are installed, simply run, in a powershell prompt, upload_all.ps1. You can provide two parameters via the command line, -directory and -titleEnd, -directory provides the directory which it will upload the video files from,
while -titleEnd will add whatever string you add to it at the end of a video. For instance, `.\upload_all.ps1 -titleEnd "Example Video"`, will upload all videos in a directory you choose via a GUI prompt
lets say there's a file called Big Fish.mp4, it'll upload that as "Big Fish Example Video". You can also specify the directory directly from the powershell if you like, using the `-directory` parameter, so
`.\upload_all.ps1 -directory "C:\Videos\Example\" -titleEnd "Example Video"` would upload any video in `C:\Videos\Example\`, such as Big Fish.mp4, with "Example Video" appended to the title. 

# Important Note

You will need to make a change to `upload_video.py`.

Specifically, you'll need to create a file called client_secrets.json, following the instructions below, and set the variable CLIENT_SECRETS_FILE to the path where you store it.

# The CLIENT_SECRETS_FILE variable specifies the name of a file that contains
# the OAuth 2.0 information for this application, including its client_id and
# client_secret. You can acquire an OAuth 2.0 client ID and client secret from
# the Google API Console at
# https://console.developers.google.com/.
# Please ensure that you have enabled the YouTube Data API for your project.
# For more information about using OAuth2 to access the YouTube Data API, see:
#   https://developers.google.com/youtube/v3/guides/authentication
# For more information about the client_secrets.json file format, see:
#   https://developers.google.com/api-client-library/python/guide/aaa_client_secrets
CLIENT_SECRETS_FILE = "C:\\Users\\bdt19\Documents_New\\Scripts\\YouTube Upload API\\client_secrets.json"

If you intend on using this for uploading many videos, you'll need to request for an API increase through Google, which will audit the program. There is a form involved you have to fill out, and it's a process. I applied for and recieved and increase of 30,000, as the default is 10,000 units. You can probably get more than that, but I was being conservative in my estimates. This is per day. I'm not sure exactly what a unit refers to, it doesn't seem to be a byte or a bit, but regardless, I found that my uploads (not huge videos, 20 minutes in length, 1080p at 20fps in H264 encoding) took approximately 1.6k units each. If you intend on doing this, I would go for a higher amount than I did, but not too high. 
