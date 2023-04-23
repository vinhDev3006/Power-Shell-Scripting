# A simple script to remove the same part of the file

$fileType = Read-Host "Enter file type (e.g. mp3, wav)"
$replaceString = Read-Host "Enter string to replace"
$folderPath = Read-Host "Enter folder path (e.g. C:\Users\UserName\Music)"

Get-ChildItem -Path $folderPath -Filter *.$fileType | ForEach-Object {
    $newName = $_.Name.Replace($replaceString, "")
    Rename-Item $_.FullName $newName
}

