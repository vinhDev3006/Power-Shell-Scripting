$sourceDir = "Your Downloads Directory"
$destinationDir = "Your Destination Directory"
$logFile = "Your Preferred Location\move_files.log"

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
            $destination = "$destinationDir\Sorted_Pictures"
        } elseif ($documentFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Sorted_Documents"
        } elseif ($videoFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Sorted_Videos"
        } elseif ($audioFileExtensions -contains $_.Extension) {
            $destination = "$destinationDir\Sorted_Music"
        } else {
            $destination = "$destinationDir\Sorted_Other"
        }

        # Check if the destination folder exists, create it if it doesn't
        if(!(Test-Path -Path $destination)){
            New-Item -ItemType Directory -Path $destination -Force | Tee-Object -FilePath $logFile -Append
        }

        # Check if the file already exists in the destination folder
        if(Test-Path -Path "$destination\$($_.Name)"){
            $fileCount = 1
            $fileName = $_.BaseName + "_" + $fileCount + $_.Extension
            while(Test-Path -Path "$destination\$fileName"){
                $fileCount++
                $fileName = $_.BaseName + "_" + $fileCount + $_.Extension
            }
            Move-Item $_.FullName "$destination\$fileName"
        } else {
            Move-Item $_.FullName $destination
        }
    }
}
