# This is a Posh script meant to create (and possibly execute, eventually?) the code necessary to run the upload_video.py with all the files
# within a directory supplied to it. 
#
# TODO: Get Python to execute the command instead of simply echoing to the terminal.
#
# Created by Ben Turner on 12-8-20 and last modified on 12-29-20.
#
# Unless otherwise stated or contradicted by original code, 
# this code is licensed under the Apache 2.0 license, 
# available here: https://www.apache.org/licenses/LICENSE-2.0

# declare global variables

# get the path that the script is being executed from
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
# debugging enabled?
$debug = $False 
# initialize an empty dictionary for the titles and directory paths to go into, do this outside of the loop.
$titles = @()
# get the argument which is the directory passed to it
$directory=$args[0]
# get the files within said directory, returning their name values. It will ignore subdirectories.
$files = (dir $directory).name
# global variables declared

# loop through the files in the directory
foreach ($f in $files){
    # get the file name without file extension, add "AOD_B Clan Brawl" to the end of it, and that's the title.
    $title = ([io.path]::GetFileNameWithoutExtension($f) + " AOD_B Clan Brawl")
    # add a new entry to the titles dictionary, with an entry containing the file name (including path) and the title.
    $titles += ([pscustomobject]@{file_name=("'"+$directory + "\" + $f +"'");title=("'" + $title + "'")})
}

# for debugging, write out the list of files and their titles, only if $debug is set to true.
if ($debug){
write-host $titles
}

# for every entry in the dictionary titles
foreach($f in $titles){
    
    # cd to the script directory, where this script and upload_video.py is
    cd $scriptPath
    
    # write to terminal the code to upload the videos for each entry in the dictionary
    write-host py -2 .\upload_video.py ("--file={0} --title={1};" -f $f.file_name,$f.title)
}