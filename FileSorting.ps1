$sourceDir = "C:\Users\vinhn\Downloads"
$destinationDir = "C:\Users\vinhn"
$logFile = "C:\Users\vinhn\move_files.log"

# All file extension collections
$imageFileExtensions = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".tiff", ".webp", ".svg", ".ico", ".heic",".jfif")
$documentFileExtensions = @(".docx",".pdf",".doc",".html",".htm",".txt",".xls",".xlsx","ppt")
$videoFileExtensions = @(".mp4", ".avi", ".mov", ".mkv", ".wmv", ".flv", ".m4v", ".mpg", ".mpeg", ".webm")
$audioFileExtensions = @(".mp3", ".wav", ".aac", ".wma", ".flac", ".m4a", ".ogg", ".ape", ".alac", ".dsd", ".aiff", ".au", ".raw", ".pcm")

# Create the log file if it doesn't exist
if(!(Test-Path -Path $logFile)){
    New-Item -ItemType File -Path $logFile -Force
}

# Loop through every item in the Downloads folder
Get-ChildItem -Path $sourceDir -Recurse | ForEach-Object{
    if($_.PSIsContainer){
        Write-Host "Skipping folder: $($_.FullName)" | Tee-Object -FilePath $logFile -Append
    } elseif($_.Extension -eq ".zip") {
        Write-Host "Skipping zip file: $($_.FullName)" | Tee-Object -FilePath $logFile -Append
    } else {
        if ($imageFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Pictures"
        } elseif ($documentFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Documents"
        } elseif ($videoFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Videos"
        } elseif ($audioFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Music"
        } else {
            $destination = "$destinationDir\Other"
        }

        # Check if the destination folder exists, create it if it doesn't
        if(!(Test-Path -Path $destination)){
            New-Item -ItemType Directory -Path $destination -Force | Tee-Object -FilePath $logFile -Append
        }

        # Check if the file already exists in the destination folder
        if(Test-Path -Path "$destination\$($_.Name)"){
            Write-Host "File $($destination)\$($_.Name) already exists." | Tee-Object -FilePath $logFile -Append
        } else {
            Move-Item $_.FullName $destination
            Write-Host "Moved file $($_.FullName) to $($destination)" | Tee-Object -FilePath $logFile -Append
        }
    }
}
