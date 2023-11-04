$folder = Read-Host "Enter folder path"
$folder -replace " ",""
$filetype = Read-Host "Enter file type (e.g. mp3)"

# Initialize the regexPattern variable
$regexPattern = Read-Host "Enter regex pattern (`hello` will remove hello, while -\w+-\d? will remove some string like -ae3se-4)"

# Create a loop to repeatedly ask the user for the regexPattern
while ($true -and $regexPattern) {

    Get-ChildItem "$folder\*.$filetype" | ForEach-Object {
        # Rename each file, removing the specified string using regex
        $newname = $_.Name -replace $regexPattern, ""
        Rename-Item $_.FullName -NewName $newname
    }

    $regexPattern = Read-Host "Next please, type "q" to quit?"
    
    if ($regexPattern -eq "q") {
        break
    }
}