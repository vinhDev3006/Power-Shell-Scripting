# Ask the user for the folder path, file type, and regex pattern
$folder = Read-Host "Enter folder path"
$filetype = Read-Host "Enter file type (e.g. mp3)"
$regexPattern = Read-Host "Enter regex pattern (`hello` will remove hello, while -\w+-\d? will remove some string like -ae3se-4)"

# Get all files of the specified type in the specified folder
Get-ChildItem $folder\*.$filetype | ForEach-Object {
    # Rename each file, removing the specified string using regex
    $newname = $_.Name -replace $regexPattern, ""
    Rename-Item $_.FullName -NewName $newname
}



