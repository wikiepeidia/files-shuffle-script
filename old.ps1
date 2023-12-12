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
$fileList = Get-ChildItem -Path $directory -Filter $fileMask

if ($fileList.Count -lt 2) {
    Write-Host "Need at least two files for shuffling."
    exit
}

# Shuffle file indices
$shuffledIndices = 0..($fileList.Count - 1) | Get-Random -Count $fileList.Count

# Perform the shuffle
for ($i = 0; $i -lt $fileList.Count; $i++) {
    $sourceIndex = $shuffledIndices[$i]
    $destinationIndex = $shuffledIndices[($i + 1) % $fileList.Count]
    
    $sourceFile = $fileList[$sourceIndex].FullName
    $destinationFile = $fileList[$destinationIndex].FullName

    Write-Host "$sourceFile >> $destinationFile"
    Move-Item -Path $sourceFile -Destination $destinationFile -Force
}
