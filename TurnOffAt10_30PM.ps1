<# 
This piece of program is created to remind me to
turn off the computer at 10:30 PM everyday, if i don't shut it down
before that time the computer will do itself at 11 PM.

Why? 🤔
Go to sleep lol

Step by step to make it automatic:
    1. Open the Task Scheduler in Windows
    2. Click on "Create Task"
    3. Give the task a name
    4. Under "Triggers", click "New" and set to trigger to "Daily" at 10:30pm
    5. Under "Actions", click "New" and set to action to "Start a program" at 10:30pm
    6. In the "Program/script" field, enter "powershell.exe"
    7. In the "Add arguments" field, enter the path the script
    8. Click OK
#>

# Load the System.Speech assembly
Add-Type -AssemblyName System.Speech

# Create a speech synthesizer object
$synthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer


# Create a speech synthesizer object
$synthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

# Get the current time and calculate the shutdown time
$currentTime = Get-Date
$shutdownTime = $currentTime.Date.AddHours(22).AddMinutes(30)

# Calculate the time until shutdown
$timeUntilShutdown = $shutdownTime - $currentTime

# Check if it's past the shutdown time
if ($currentTime -gt $shutdownTime) {
    $message = "It's past 10:30 PM. Your computer will shut down in 30 minutes."
    Write-Host $message
    $synthesizer.Speak($message)

    # Shutdown the computer after 30 minutes
    Start-Sleep -Seconds 1800
    Stop-Computer -Force

} else {
    $message = "Your computer will shut down at 10:30 PM."
    Write-Host $message
    $synthesizer.Speak($message)

    # Shutdown the computer at the specified time
    Start-Sleep -Seconds $timeUntilShutdown.TotalSeconds
    Stop-Computer -Force
}