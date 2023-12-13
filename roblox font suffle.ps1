param (
    [string]$directory = "",
    [string]$fileMask = "*"
)

if ($directory -eq "" -or -not (Test-Path $directory)) {
    Write-Host "Usage: FileNameRandomizer.ps1 -directory {directory} [-fileMask {file mask}]"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  FileNameRandomizer.ps1 -directory 'C:\Users\phamt\OneDrive - caugiay.edu.vn\Máy tính\New folder'"
    Write-Host "  FileNameRandomizer.ps1 -directory '..\testdir' -fileMask '*.txt'"
    Write-Host "  FileNameRandomizer.ps1 -directory 'testdir' -fileMask 'the file*.*'"
    exit
}

# Get the list of files
$fileList = Get-ChildItem -Path $directory -Filter $fileMask | Where-Object { -not $_.PSIsContainer }

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
Remove-Item -Path $tempDirectory -Force -Recur