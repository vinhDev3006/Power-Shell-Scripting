
# Ask the user for the folder path, file type, and string to replace
$folder = Read-Host "Enter folder path:"
$filetype = Read-Host "Enter file type (e.g. mp3):"
$replace = Read-Host "Enter string to replace:"

# Get all files of the specified type in the specified folder
Get-ChildItem $folder\*.$filetype | ForEach-Object {
    # Rename each file, removing the specified string
    $newname = $_.Name.Replace($replace, "")
    Rename-Item $_.FullName -NewName $newname
}



