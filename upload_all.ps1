$directory=$args[0]

$files = (dir $directory).name
$titles = @()
foreach ($f in $files){
    $title = ([io.path]::GetFileNameWithoutExtension($f) + " AOD_B Clan Brawl")
    $titles += ([pscustomobject]@{file_name=("'"+$directory + "\" + $f +"'");title=("'" + $title + "'")})
}
write-host $titles
foreach($f in $titles){
    #$a =' --file={0} --title={1}' -f $f.file_name, $f.title
    #write-host $a
    #C:\Python27\python.exe 'C:\Users\bdt19\Documents_New\Scripts\YouTube Upload API\upload_video.py'($a)
    cd "C:\Users\bdt19\Documents_New\Scripts\YouTube Upload API\"
    write-host py -2 .\upload_video.py ("--file={0} --title={1}" -f $f.file_name,$f.title)
    #write-host $a
}