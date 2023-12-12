#IMPROVED FROM CMD BY CHAT-GPT 08:03:43 12/12/2023
#performance for 1176 items(core i5 6300u): approx 3s, compared to 18s of cmd
#FIRST RUN: RUN "Set-ExecutionPolicy -ExecutionPolicy bypass" (PS must admin) then press A for guranteed run.
<#
UASGE:
GitHub Copilot: The selected code is a PowerShell script that shuffles the names of files in a specified directory. Here's a breakdown of what the code does:

1. It accepts two parameters: `$directory` and `$fileMask`. `$directory` is the directory where the files to be shuffled are located, and `$fileMask` is a pattern that can be used to select specific files within the directory.

2. It checks if the `$directory` parameter is empty or if the directory does not exist. If either of these conditions is true, it prints usage instructions and exits the script.

3. It retrieves a list of files in the specified directory that match the `$fileMask` pattern.

4. It checks if the number of files retrieved is less than 2. If so, it prints a message indicating that at least two files are needed for shuffling and exits the script.

5. It creates a temporary directory within the specified directory. This temporary directory is used during the shuffling process.

6. It generates a list of shuffled indices. These indices correspond to the positions of the files in the `$fileList`.

7. It iterates over the `$fileList` and for each file, it calculates a source index and a destination index based on the shuffled indices. The source index is the current index in the shuffled list, and the destination index is the next index in the shuffled list, wrapping around to the start of the list if necessary.

8. Move shuffled files back to the original directory 

9. delete the TEMP
#>
param (
    [string]$directory = "",
    [string]$fileMask = "*"
)

if ($directory -eq "" -or -not (Test-Path $directory)) {
    Write-Host "Usage: FileNameRandomizer.ps1 -directory {directory} [-fileMask {file mask}]"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  FileNameRandomizer.ps1 -directory 'C:\winnt\system32\new folder'"
    Write-Host "  FileNameRandomizer.ps1 -directory '..\testdir' -fileMask '*.txt'"
    Write-Host "  FileNameRandomizer.ps1 -directory 'testdir' -fileMask 'the file*.*'"
    exit
}

# Get the list of files
$fileList = Get-ChildItem -Path $directory -Filter $fileMask

if ($fileList.Count -lt 2) {
    Write-Host "Need at least two files for shuffling."
    exit
}

# Create a temporary directory for shuffling
$tempDirectory = Join-Path -Path $directory -ChildPath "TempShuffle"
New-Item -ItemType Directory -Force -Path $tempDirectory | Out-Null

# Shuffle file indices
$shuffledIndices = 0..($fileList.Count - 1) | Get-Random -Count $fileList.Count

# Perform the shuffle
for ($i = 0; $i -lt $fileList.Count; $i++) {
    $sourceIndex = $shuffledIndices[$i]
    $destinationIndex = $shuffledIndices[($i + 1) % $fileList.Count]
    
    $sourceFile = $fileList[$sourceIndex].FullName
    $destinationFile = Join-Path -Path $tempDirectory -ChildPath ($fileList[$destinationIndex].Name)

    Write-Host "$sourceFile >> $destinationFile"
    Move-Item -Path $sourceFile -Destination $destinationFile -Force
}

# Move shuffled files back to the original directory
Get-ChildItem -Path $tempDirectory | Move-Item -Destination $directory -Force

# Remove temporary directory
Remove-Item -Path $tempDirectory -Force -Recurse
