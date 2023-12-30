param (
    [string]$directory = "",
    [string]$fileMask = "*"
)

if ($directory -eq "" -or -not (Test-Path $directory)) {
    Write-Host "Directory not found or not correct."
    Write-Host "Usage: FileNameRandomizer.ps1 -directory {directory} [-fileMask {file mask}]"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  FileNameRandomizer.ps1 -directory 'C:\Users\phamt\OneDrive - caugiay.edu.vn\Máy tính\New folder'"
    Write-Host "  FileNameRandomizer.ps1 -directory '..\testdir' -fileMask '*.txt'"
    Write-Host "  FileNameRandomizer.ps1 -directory 'testdir' -fileMask 'the file*.*'"
    exit
}

function Shuffle-Files {
    param($index, $fileList, $tempDirectory)

    $localSourceIndex = $index
    $localDestinationIndex = ($index + 1) % $fileList.Count

    $localSourceFile = $fileList[$localSourceIndex].FullName
    $localDestinationFile = Join-Path -Path $tempDirectory -ChildPath ($fileList[$localDestinationIndex].Name)

    Move-Item -Path $localSourceFile -Destination $localDestinationFile -Force

    $localDestinationFile  # Return the moved file path
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

# Variable to store moved file paths
$shuffledFiles = @()

foreach ($shuffledIndex in $shuffledIndices) {
    $shuffledFile = Shuffle-Files -index $shuffledIndex -fileList $fileList -tempDirectory $tempDirectory
    $shuffledFiles += $shuffledFile
}

# Move shuffled files back to the original directory
$shuffledFiles | ForEach-Object {
    Move-Item -Path $_ -Destination $directory -Force
}

# Remove temporary directory
Remove-Item -Path $tempDirectory -Force -Recur
