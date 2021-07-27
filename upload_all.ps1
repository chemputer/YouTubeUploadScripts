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

# Folders from here : https://code.adonline.id.au/folder-file-browser-dialogues-powershell/
param (
    [string]$directory,
    [string]$titleEnd
)

$debug = $false
$progressoutput = $true
function Find-Folders {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $pathset = $false
    if (Test-Path 'env:uploadSelectedPath'){
        $browse.SelectedPath = $env:uploadSelectedPath
        $pathset = $true
    }else{
    $browse.SelectedPath = $env:SYSTEMDRIVE + "\" #E:\Games\WoWS Replays\Outplayed\World of Warships\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"}

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
            $store = Split-Path -Path $browse.SelectedPath -Parent
            [System.Environment]::SetEnvironmentVariable('uploadSelectedPath',[string]$store)
		    if($debug){write-host $env:uploadSelectedPath}
            return $browse.SelectedPath
		#Insert your script here
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} 


# declare global variables

# get the path that the script is being executed from
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
# debugging enabled?

# initialize an empty dictionary for the titles and directory paths to go into, do this outside of the loop.
$titles = @()


# get the argument which is the directory passed to it
#$directory=$args[0]
if ($directory -eq ''){
    $newdir = Find-Folders
    
    if ($debug)
    {Write-Host $newdir}

    $directory = $newdir
}
if ($debug)
{Write-Host $directory}
# get the files within said directory, returning their name values. It will ignore subdirectories.
$files = (dir $directory).name
# global variables declared
#$ymd_date = Get-Date -Uformat "%Y-%m-%d"
# loop through the files in the directory

foreach ($f in $files){
    # get the file name without file extension, add "AOD_B Clan Brawl" to the end of it, and that's the title.
    $titleExt = ''
    if ($titleEnd.length -gt 0){
        $titleExt = " " + $titleEnd
        }
    $title = ([io.path]::GetFileNameWithoutExtension($f) + $titleExt)
    # add a new entry to the titles dictionary, with an entry containing the file name (including path) and the title.

    $titles += ([pscustomobject]@{file_name=("'"+$directory + "\" + $f +"'");title=("'" + $title + "'")})
}

# for debugging, write out the list of files and their titles, only if $debug is set to true.
#if ($debug){
#write-host $titles
#}

# for every entry in the dictionary titles
foreach($f in $titles){
    
    # cd to the script directory, where this script and upload_video.py is
    cd $scriptPath
    if ($progressoutput){write-host "Uploading: "$f.title}
    # write to terminal the code to upload the videos for each entry in the dictionary
    iex -Command ("py -2 .\upload_video.py --file={0} --title={1}" -f $f.file_name,$f.title)
    #write-host py -2 .\upload_video.py ("--file={0} --title={1};" -f $f.file_name,$f.title)
}